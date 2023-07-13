class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit]
  
  def show
    @member = Member.find(params[:id])
    @post = @member.posts
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

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end
  
  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end
  
end