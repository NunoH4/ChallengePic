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
  

  # ゲストログイン機能
  GUEST_MEMBER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guest"
    end
  end
  
  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end
end