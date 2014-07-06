class Photo < ActiveRecord::Base
  has_attached_file :photo_file,
    styles: {small: "150x150>", large: "300x300>"},
    default_url: "/images/default.jpg"

  after_create :ensure_photo_id
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/

  belongs_to :photo_file

  private

  def ensure_photo_id
    self.photo_id = User.find(user_id).photos.map(&:photo_id).max.to_i + 1
  end
end