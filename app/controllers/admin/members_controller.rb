class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path(@member.id)
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :profile_image, :is_deleted)
  end
end
