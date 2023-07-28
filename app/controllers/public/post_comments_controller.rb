class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :is_matching_login_member, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post = @post_comment.post
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def is_matching_login_member
    post_comment = PostComment.find(params[:id])
    unless post_comment.member.id == current_member.id
      flash[:error] = "権限がありません。"
      redirect_to post_path(post_comment.post)
    end
  end
end