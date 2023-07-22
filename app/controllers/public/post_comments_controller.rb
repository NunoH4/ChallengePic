class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

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
end