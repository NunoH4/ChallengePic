class Public::PostsController < ApplicationController
  
  def new
    @daily_theme = Challenge.last&.theme
    @post = Post.new
  end

  def index
    @posts = Post.all
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.theme = Challenge.last&.theme
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post), notice:'投稿が完了しました'
    else
      puts @post.errors.full_messages.to_s
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end
  
  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    
    if @post.update(post_params)
      # このpost_idに紐づいていたタグを@oldに入れる
      @old_relations=PostTag.where(post_id: @post.id)
      # それらを取り出して順に全て消す。
      @old_relations.each do |relation|
      relation.delete
      end
      @post.save_tag(tag_list)
      redirect_to post_path(@post), notice: "投稿を更新しました"
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
    params.require(:post).permit(:image, :body)
  end
end
