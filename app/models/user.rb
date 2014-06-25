class User < ActiveRecord::Base
  attr_reader :password
  
  before_validation :ensure_session_token
  before_validation :ensure_age_preferences
  
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
  
  def self.now
    Time.now.utc.to_date
  end

  def age
    now = User.now
    now.year - dob.year - ((now.month > dob.month ||
      (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  def users(options = {})
    defaults = {
      show_me: [],
      who_like: gender,
      min_age: min_age,
      max_age: max_age
    }
    defaults[:show_me] << "m" if likes_m
    defaults[:show_me] << "f" if likes_f
    
    options = defaults.merge(options)
    
    now = User.now
    min_dob = Date.new(now.year - max_age, now.month, now.day)
    max_dob = Date.new(now.year - min_age, now.month, now.day)
    
    users = []
    options[:show_me].each do |gender|
      users.concat(
        User.where(
          "(gender='#{gender}') AND 
          (likes_#{options[:who_like]}=true) AND
          (dob BETWEEN '#{min_dob}' AND '#{max_dob}')"
        )
      )
    end
    users
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
  
  def orientation=(pref)
    case self.gender
    when "m"
      case pref
      when "straight"
        self.likes_f = true
      when "gay"
        self.likes_m = true
      when "bisexual"
        self.likes_f, self.likes_m = true, true
      end
    when "f"
      case pref
      when "straight"
        self.likes_m = true
      when "gay"
        self.likes_f = true
      when "bisexual"
        self.likes_m, self.likes_f = true, true
      end
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

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