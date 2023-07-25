class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image
  
  validates :name, length: { minimum: 1, maximum: 15 }
  validates :introduction, length: { maximum: 150 }
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @member = Member.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @member = Member.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @member = Member.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @member = Member.where("name LIKE?","%#{word}%")
    else
      @member = Member.all
    end
  end
  
  def active_for_authentication?
    super && (is_deleted == false)  # is_deletedがfalseならtrueを返すようにする
  end
  
end
