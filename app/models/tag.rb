class Tag < ApplicationRecord
  # タグ付けのバリデーション・アソシエーション
  has_many :post_tag_relationships, dependent: :destroy
  has_many :posts, through: :post_tag_relationships
  
  validates :name, presence:true, length:{maximum:20}
end