Rails.application.routes.draw do
  get 'homes/top'
  devise_for :members
  root to: 'homes#top'
end
