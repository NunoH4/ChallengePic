class Public::HomesController < ApplicationController

  def top
    @daily_theme = Challenge.last&.theme
  end

  def guideline
  end
end
