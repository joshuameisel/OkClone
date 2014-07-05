class Photo < ActiveRecord::Base
  has_attached_file :photo_file, styles: {small: "150x150>", large: "300x300>"}

  before_validation :ensure_photo_id
  validates :user_id, :photo_id, presence: true
  validates_attachment_presence :photo_file
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/

  belongs_to :photo_file

  private

  def ensure_photo_id
    self.photo_id = User.find(user_id).photos.map(&:photo_id).max.to_i + 1
  end
end
