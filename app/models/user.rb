class User < ActiveRecord::Base
  GENDERS = {0 => ["f"], 1 => ["m"], 2 => ["f", "m"]}

  attr_reader :password
  
  geocoded_by :zip_code

  has_one :profile
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id
  has_many :photos, dependent: :destroy
  has_many :answers
  has_many :answered_questions, through: :answers, source: :question
  has_many :acceptable_answers
  has_many :answer_choices, through: :answers

  before_validation :ensure_session_token
  before_validation :ensure_age_preferences
  before_validation :geocode, if: :zip_code_changed?
  after_validation :ensure_city
  after_create :make_profile

  validates :username, :gender, :min_age, :max_age, :dob,
    :country, :session_token, :email,
    presence: true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :username, :email, :session_token, uniqueness: true
  validate :zip_code_is_proper
  validate :password_digest_presence

  def match_percentage(match)
    (Question.find_by_sql(<<-SQL)
      SELECT SUM(match) * 100 / COUNT(*) AS match_pct
      FROM (
        SELECT MAX(CASE WHEN acceptable_acs.id=answer_acs.id 
                        THEN 1.0 ELSE 0 END) AS match
        FROM questions
        JOIN answer_choices acceptable_acs 
          ON questions.id=acceptable_acs.question_id
        JOIN acceptable_answers 
          ON acceptable_answers.answer_choice_id = acceptable_acs.id
        JOIN answer_choices answer_acs 
          ON questions.id=answer_acs.question_id
        JOIN answers
          ON answers.answer_choice_id = answer_acs.id
        WHERE acceptable_answers.user_id=#{id} AND answers.user_id=#{match.id}
        GROUP BY questions.id
      ) AS matches
    SQL
    .first.match_pct || 0).round
  end
  
  def distance(match)
    User.where("id=?", match.id).pluck(distance_str).first.round
  end
  
  def distance_str
    "(DEGREES(
        ACOS(
          SIN(RADIANS( #{latitude} )) * SIN(RADIANS( latitude ))
          + COS(RADIANS( #{latitude} )) * COS(RADIANS( latitude ))
          * COS(RADIANS( #{longitude} - longitude ))
        ) * 60 * 1.1515
      ))"
  end

  def profile_pic
    photos.find_by(photo_id: 1)
  end

  def unread_messages_count
    received_messages.where(read_status: 0).count
  end

  def conversations
    Message.find_by_sql(<<-SQL)
      SELECT stripped_msgs.* FROM
        (SELECT DISTINCT ON (full_msgs.other_user_id) full_msgs.other_user_id, 
          full_msgs.created_at, full_msgs.body
        FROM (
          SELECT (CASE 
              WHEN messages.sender_id=#{id} 
              THEN messages.recipient_id 
              ELSE messages.sender_id 
              END) AS other_user_id, body, created_at
          FROM messages
          WHERE messages.sender_id=#{id} OR
          messages.recipient_id=#{id}
          ORDER BY created_at DESC
        ) AS full_msgs) AS stripped_msgs
      ORDER BY stripped_msgs.created_at DESC
    SQL
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.genders(num)
    GENDERS[num]
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month ||
      (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.other_gender(gender)
    gender == "m" ? "f" : "m"
  end

  def show_me_value
    GENDERS.invert[likes]
  end

  def likes
    case self.orientation
    when "straight"
      [User.other_gender(gender)]
    when "gay"
      [gender]
    when "bisexual"
      [gender, User.other_gender(gender)]
    end
  end

  def defaults
    {
      show_me: likes,
      who_like: [gender], 
      min_age: min_age, 
      max_age: max_age, 
      order_by: "random",
      within: 50
    }
  end
  
  def self.order_str
    {
      "random" => "RANDOM()",
      "match" => "match_pct DESC",
      "distance" => "distance"
    }
  end

  def users(options = nil)    
    options ||= defaults
    show_me = options[:show_me]
    who_like = options[:who_like]

    now = Time.now.utc.to_date
    min_dob = Date.new(now.year - options[:max_age], now.month, now.day)
    max_dob = Date.new(now.year - options[:min_age], now.month, now.day)
    
    where_str = "(id!=#{id}) AND (dob BETWEEN ? AND ?)"
    where_args = [min_dob, max_dob]

    # easy case where we only (possibly) care about gender, not orientation
    if who_like.length == 2
      if show_me.length < 2
        where_str.concat("AND (gender=?)")
        where_args << show_me.first
      end

    # hard case where we care about orientation
    else
      where_concats = []

      show_me.each do |gen|
        orientations = ["bisexual"].concat([
          gen == who_like.first ? "gay" : "straight"
        ])

        where_concats << "(gender=? AND users.orientation IN (?))"
        where_args.concat([gen, orientations])
      end

      where_str.concat(" AND (#{where_concats.join(' OR ')})")
    end
    
    if options[:within]
      where_str.concat(" AND (#{distance_str}<=#{options[:within]})") 
    end
        
    User.find_by_sql([<<-SQL, *where_args])
      SELECT *, #{distance_str} AS distance
      FROM (
        SELECT CASE WHEN MAX(match) IS NOT NULL 
                    THEN SUM(match) * 100 / COUNT(*) 
                    ELSE 0
               END AS match_pct, users.*
        FROM (
          SELECT MAX(CASE WHEN acceptable_acs.id=answer_acs.id THEN 1.0 ELSE 0
                     END) AS match, answers.user_id
          FROM questions
          JOIN answer_choices acceptable_acs 
            ON questions.id=acceptable_acs.question_id
          JOIN acceptable_answers 
            ON acceptable_answers.answer_choice_id = acceptable_acs.id
          JOIN answer_choices answer_acs 
            ON questions.id=answer_acs.question_id
          JOIN answers
            ON answers.answer_choice_id = answer_acs.id
          WHERE acceptable_answers.user_id=#{id}
          GROUP BY answers.user_id, questions.id
        ) as matches RIGHT OUTER JOIN users ON matches.user_id = users.id
        GROUP BY users.id
      ) as users
      WHERE #{where_str}
      ORDER BY #{User.order_str[options[:order_by]]}
      SQL
  end

  def is_password?(unencrypted_password)
    BCrypt::Password
      .new(self.password_digest)
      .is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    # BCrypt will happily encrypt an empty string
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest =
        BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

  def make_profile
    self.profile = Profile.create
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def ensure_city
    self.city = 
      Geocoder.search("#{latitude},#{longitude}")
              .first
              .data["formatted_address"]
              .split(", ")[-3]
  end

  def ensure_age_preferences
    if !min_age || !max_age
      self.min_age, self.max_age = 18, 30
    end
  end

  def password_digest_presence
    errors.add(:password, "can't be blank") unless password_digest
  end

  def zip_code_is_proper
  end
end