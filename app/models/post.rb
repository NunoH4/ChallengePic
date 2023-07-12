class Post < ApplicationRecord
  has_one_attached :image
  # has_many :post_tag_relationships, dependent: :destroy
  # has_many :tags, through: :tag_relationships
  belongs_to :member

end