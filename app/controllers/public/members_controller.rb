class Public::MembersController < ApplicationController
  before_action :correct_member, only: [:update, :edit, :leave, :withdrawal]
  
  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.order(created_at: :desc).page(params[:page]).per(6) #デフォルトを新着順に
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Post.where(id: favorites).order(created_at: :desc).page(params[:page]).per(6)  # postsテーブルからお気に入り登録済みのレコードを取得
  end

  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def leave
    @member = Member.find(current_member.id)
  end

  def withdrawal
    @member = Member.find(params[:id])
    @member.update(is_deleted: true) # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end
  
  def correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end
  
end