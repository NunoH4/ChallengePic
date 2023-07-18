class Public::HomesController < ApplicationController

  def top
    @daily_theme = Challenge.last&.theme || "no theme"
    # 毎日4:30にお題が更新されるため、+ 4.hours + 30.minutes
    @posts = Post.where("created_at >= ?", Time.current.beginning_of_day + 4.hours + 30.minutes)
  end

  def guideline
  end
end
