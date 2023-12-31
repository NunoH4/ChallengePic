class Public::RelationshipsController < ApplicationController
  
  # フォロー時
  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end
  
  # フォロー解除時
  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer  
  end
  
  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
end
