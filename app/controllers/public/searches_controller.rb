class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]

    if @range == "ユーザー"
      @members = Member.looks(params[:search], params[:word])
    elsif @range == "Challenge Theme"
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(6)
    else
      @tags = Tag.looks(params[:search], params[:word])
      @posts = @tags.flat_map(&:posts)
    end
  end
end