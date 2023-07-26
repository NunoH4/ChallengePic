class Admin::PostsController < ApplicationController
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_member_path(post.member), flash: {success: "投稿の削除が完了しました"}
  end
  
end
