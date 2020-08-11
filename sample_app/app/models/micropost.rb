class Micropost < ApplicationRecord
  PARAMS = %i(content image).freeze

  belongs_to :user
  has_one_attached :image
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_max_length }
  validate  :picture_size

  scope :created_post_at, ->{order(created_at: :desc)}

  def picture_size
    errors.add(:picture, t("microposts.should_be_less_than")) if picture.size > Settings.micropost.image.size.megabytes
  end
end
