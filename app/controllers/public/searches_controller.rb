class Public::SearchesController < ApplicationController

  def search
      @range = params[:range]
  
      if @range == "ユーザー"
        @members = Member.looks(params[:search], params[:word]).page(params[:page]).per(6)
      elsif @range == "Challenge Theme"
        if params[:latest] #新しい順
          @posts = Post.looks(params[:search], params[:word]).latest.page(params[:page]).per(6)
        elsif params[:old] #古い順
          @posts = Post.looks(params[:search], params[:word]).old.page(params[:page]).per(6)
        elsif params[:most_favorited] #お気に入り順
          @posts = Post.looks(params[:search], params[:word]).most_favorited.page(params[:page]).per(6)
        else
          @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(6) #デフォルトを新着順に
        end
      else
        @tags = Tag.looks(params[:search], params[:word])
        @posts = @tags.flat_map(&:posts)
      end
    end
end