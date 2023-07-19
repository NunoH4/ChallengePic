class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post
  

  # お気に入り登録
  def create
    if @post.member_id != current_member.id   # 投稿者本人以外に限定
      @favorite = Favorite.create(member_id: current_member.id, post_id: @post.id)
    end
  end
  
  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(member_id: current_member.id, post_id: @post.id)
    @favorite.destroy
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
end
