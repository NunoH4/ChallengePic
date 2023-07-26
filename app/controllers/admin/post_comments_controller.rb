class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @member = Member.find(params[:member_id])
    @post_comments = @member.post_comments.page(params[:page]).per(25)
  end
  
  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to admin_member_post_comments_path(post_comment.member), flash: {success: "コメントの削除が完了しました"}
  end
end
