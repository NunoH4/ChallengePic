class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :post
  
  validates :comment, presence:true, length: { minimum: 1, maximum: 150 }
end