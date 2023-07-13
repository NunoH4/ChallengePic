class Post < ApplicationRecord
  # has_many :post_tag_relationships, dependent: :destroy
  # has_many :tags, through: :tag_relationships
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

end