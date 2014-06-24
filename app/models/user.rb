class User < ActiveRecord::Base
  attr_reader :password
  
  before_validation :ensure_session_token
  
  validates :username, :gender, :orientation, :birthdate, :country, 
    :session_token, :zip_code, :email, 
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

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def password_digest_presence
    errors.add(:password, "can't be blank") unless password_digest
  end
  
  def zip_code_is_proper
  end
end