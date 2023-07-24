class Admin::PostCommentsController < ApplicationController
  
  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to admin_member_path(post_comment.member)
  end
end