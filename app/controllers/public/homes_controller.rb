class Public::HomesController < ApplicationController

  def top
    @daily_theme = Challenge.last&.theme || "no theme"
    # 毎日4:30にお題が更新されるため
    if Time.current.hour < 4 || (Time.current.hour == 4 && Time.current.min < 30)
      from = Time.current.yesterday.beginning_of_day + 4.hours + 30.minutes
    else
      from = Time.current.beginning_of_day + 4.hours + 30.minutes
    end
    @posts = Post.where("created_at >= ?", from).all.order(created_at: :desc).page(params[:page]).per(12)
    
    start_date = Time.current.beginning_of_month
    end_date = Time.current.end_of_month
    @rank_posts = Post.where(created_at: start_date..end_date)
                        .left_joins(:favorites)
                        .group(:id)
                        .order('COUNT(favorites.id) DESC')
                        .limit(3)
  end

  def guideline
  end
end
