class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_member, only: [:show, :edit, :update]
  
  def index
    @members = Member.all.page(params[:page]).per(20)
  end

  def show
    @member = Member.find(params[:id])
    @post = @member.posts
    @post_comment = @member.post_comments
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path(@member.id), flash: {success: "ユーザー情報を更新しました。"}
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :profile_image, :is_deleted)
  end
  
  def ensure_member
    @member = Member.find(params[:id])
  end
end
