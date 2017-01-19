class Tweet < ApplicationRecord
  validates :image, presence: true
  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :message, presence:true, length: { maximum: 140 }
  validates :user_id, presence: true
  belongs_to :user
end
