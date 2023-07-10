class Public::HomesController < ApplicationController
  def top
    @daily_theme = Faker::Name.name
  end
  
  def guideline
  end
end
