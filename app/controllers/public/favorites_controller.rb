class Public::FavoritesController < ApplicationController
  before_action :set_post

  def create
    if member_signed_in?
      if @post.member_id != current_member.id # 投稿者本人以外に限定
        @favorite = Favorite.create(member_id: current_member.id, post_id: @post.id)
      else
        @error_message = "投稿者自身はお気に入り登録できません"
      end
    else
      @error_message = "ユーザーログインしてください"
    end
  end

  def destroy
    @favorite = Favorite.find_by(member_id: current_member.id, post_id: @post.id)
    @favorite.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end