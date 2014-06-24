class User < ActiveRecord::Base
  validates :username, :orientation, :birthdate, :country, :zip_code, :email, 
    :password_digest, presence: true
  validates :username, uniqueness: true
end