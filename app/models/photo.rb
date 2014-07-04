class Photo < ActiveRecord::Base
  has_attached_file :photo_file, styles: {small: "150x150>", large: "300x300>"}
  validates_attachment_presence :photo_file
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/

  belongs_to :photo_file
end
