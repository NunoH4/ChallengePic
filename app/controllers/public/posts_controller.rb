class Public::PostsController < ApplicationController
  
  def new
    @theme = Challenge.last&.theme
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.theme = Challenge.last&.theme
    if @post.save
      redirect_to posts_path, notice:'投稿が完了しました'
    else
      puts @post.errors.full_messages.to_s
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path(@post), notice: "You have updated post successfully."
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end
  
  private

  def post_params
    params.require(:post).permit(:image, :body, :theme)
  end
end
