class Tag < ApplicationRecord
  # タグ付けのバリデーション・アソシエーション
  has_many :post_tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ（post_tag_relationshipsを通じて参照できる）
  has_many :posts, through: :post_tag_relations
  
  validates :name, uniqueness: true, presence: true
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end
  
end