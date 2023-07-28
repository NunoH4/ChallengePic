class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @member = Member.find(params[:member_id])
    @posts = @member.posts.page(params[:page]).per(25)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_member_posts_path(post.member), flash: {success: "投稿の削除が完了しました。"}
  end
  
end
