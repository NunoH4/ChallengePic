class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to post_path
  end
  
  private

  def post_params
    params.require(:post).permit(:image, :body)
  end
end
