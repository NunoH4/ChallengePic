class Public::MembersController < ApplicationController
  before_action :is_matching_login_member, only: [:update, :edit, :leave, :withdrawal]
  before_action :ensure_guest_member, only: [:leave, :update]

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.order(created_at: :desc).page(params[:page]).per(12) #デフォルトを新着順に
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Post.where(id: favorites).order(created_at: :desc).page(params[:page]).per(12)  # postsテーブルからお気に入り登録済みのレコードを取得
    @tab = params[:tab] || 'post'
    @following = @member.followings
    @followers = @member.followers
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    if @member.update(member_params)
      redirect_to member_path(@member), flash: {success: "ユーザー情報を更新しました。"}
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
    redirect_to root_path, flash: {success: "退会処理を実行しました。"}
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_member
    @member = Member.find(params[:id])
    unless @member == current_member
      flash[:error] = "権限がありません。"
      redirect_to member_path(current_member)
    end
  end
  
  def ensure_guest_member
   if current_member.guest_member?
     redirect_to member_path(current_member), flash: {warning: "ゲストユーザーには権限がありません。"}
   end
  end
end