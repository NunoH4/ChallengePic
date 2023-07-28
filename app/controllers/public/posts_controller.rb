class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show, :search_tag]
  before_action :is_matching_login_member, only: [:edit, :update, :destroy]
  
  def new
    @daily_theme = Challenge.last&.theme
    @post = Post.new
  end

  def index
    if params[:latest] #新しい順
      @posts = Post.latest.page(params[:page]).per(6)
    elsif params[:old] #古い順
      @posts = Post.old.page(params[:page]).per(6)
    elsif params[:most_favorited] #お気に入り順
      @posts = Post.most_favorited.page(params[:page]).per(6)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(6) #デフォルトを新着順に
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end
  
  def create
    @post = Post.new(image_resize(post_params.except(:name))) #post_paramsからTagのカラムを除外
    @post.member_id = current_member.id
    @post.theme = Challenge.last&.theme
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post), flash: {success: "投稿が完了しました"}
    else
      @daily_theme = Challenge.last&.theme
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
    
    if @post.update(post_params.except(:name))
      # このpost_idに紐づいていたタグを@oldに入れる
      @old_relations=PostTagRelation.where(post_id: @post.id)
      # それらを取り出して順に全て消す。
      @old_relations.each do |relation|
      relation.delete
      end
      @post.save_tag(tag_list)
      redirect_to post_path(@post), flash: {success: "投稿の編集が完了しました。"}
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, flash: {success: "投稿の削除が完了しました。"}
  end
  
  def search_tag
    @tag = Tag.find(params[:tag_id])
    if params[:latest] #新しい順
      @posts = @tag.posts.latest.page(params[:page]).per(6)
    elsif params[:old] #古い順
      @posts = @tag.posts.old.page(params[:page]).per(6)
    elsif params[:most_favorited] #お気に入り順
      @posts = @tag.posts.most_favorited.page(params[:page]).per(6)
    else
      @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(6) #デフォルトを新着順に
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:image, :body, :name) #:nameはTagのカラム
  end
  
  def image_resize(params) #保存前にリサイズする
    if params[:image]
      params[:image].tempfile = ImageProcessing::MiniMagick.source(params[:image].tempfile).resize_to_limit(800, 800).call
    end
    params
  end
  
  def is_matching_login_member
    post = Post.find(params[:id])
    unless post.member.id == current_member.id
      flash[:error] = "権限がありません。"
      redirect_to post_path(post)
    end
  end
end
