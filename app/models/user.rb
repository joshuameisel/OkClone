class User < ActiveRecord::Base
  GENDERS = {0 => ["f"], 1 => ["m"], 2 => ["f", "m"]}

  attr_reader :password

  has_one :profile

  before_validation :ensure_session_token
  before_validation :ensure_age_preferences
  after_create :make_profile

  validates :username, :gender, :min_age, :max_age, :dob,
    :country, :session_token, :email,
    presence: true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :username, :email, :session_token, uniqueness: true
  validate :zip_code_is_proper
  validate :password_digest_presence

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

  def users(options = {})
    defaults = {
      show_me: likes,
      who_like: [gender],
      min_age: min_age,
      max_age: max_age
    }

    options = defaults.merge(options)
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
        where_str.concat(" AND (gender=?)")
        where_args << show_me.first
      end

    # hard case where we care about orientation
    else
      where_str.concat(" AND ")
      where_concats = []

      show_me.each do |gen|
        orientations = ["bisexual"].concat([
          gen == who_like.first ? "gay" : "straight"
        ])

        where_concats << "(gender=? AND orientation IN (?))"
        where_args.concat([gen, orientations])
      end

      where_str.concat("(#{where_concats.join(' OR ')})")
    end

    User.where(where_str, *where_args)
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