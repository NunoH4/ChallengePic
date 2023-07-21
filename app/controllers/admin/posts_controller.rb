class Admin::PostsController < ApplicationController
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_member_path(post.member)
  end
  
end
