class Photo < ActiveRecord::Base
  has_attached_file :photo_file, styles: {
    index: "240x200#>",
    profile: "160x160#>",
    full: "558x800>"
  }

  after_create :ensure_photo_id
  validates :user_id, presence: true
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/

  belongs_to :photo_file

  private

  def ensure_photo_id
    self.update_attributes(
      photo_id: User.find(user_id).photos.map(&:photo_id).compact.max.to_i + 1)
  end
end