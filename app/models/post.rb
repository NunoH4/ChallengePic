class Post < ApplicationRecord
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  # タグ付け機能
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - sent_tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = sent_tags - current_tags
  
      # 古いタグを消す
      old_tags.each do |old|
        self.tags.delete　Tag.find_by(name: old)
      end
  
      # 新しいタグを保存
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new)
        self.tags << new_post_tag
     end
  end
  
  # お気に入り機能
  def favorited_by?(member)
    return false if member.nil? #未ログインユーザーの場合nilではなくfalseを返すようにする
    favorites.exists?(member_id: member.id)
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("theme LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("theme LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("theme LIKE?","%#{word}")
    elsif search == "partial_match"
      @postk = Post.where("theme LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  

end