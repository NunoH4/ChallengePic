class Tag < ApplicationRecord
  # タグ付けのバリデーション・アソシエーション
  has_many :post_tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ（post_tag_relationshipsを通じて参照できる）
  has_many :posts, through: :post_tag_relations
  
  validates :name, uniqueness: true, presence: true
end