class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show, :search_tag]
  
  def new
    @daily_theme = Challenge.last&.theme
    @post = Post.new
  end

  def index
    @tag_list=Tag.all
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
      redirect_to post_path(@post), notice:'投稿が完了しました'
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
  
  def search_tag
    # 　検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 　検索されたタグに紐づく投稿を表示
    @posts = @tag.posts
  end
  
  private

  def post_params
    params.require(:post).permit(:image, :body, :name) #:nameはTagのカラム
  end
  
  def image_resize(params)
    if params[:image]
      params[:image].tempfile = ImageProcessing::MiniMagick.source(params[:image].tempfile).resize_to_limit(800, 800).call
    end
    params
  end
end
