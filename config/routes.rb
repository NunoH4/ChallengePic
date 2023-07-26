Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "members#index"
    resources :members, only: [:show, :edit, :update] do
      resources :posts, only: [:index, :destroy]
      resources :post_comments, only: [:index, :destroy]
    end
  end

  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root 'homes#top'
    get 'homes/guideline' => 'homes#guideline'
    get "search_tag" => "posts#search_tag"
    get "search" => "searches#search"
    resources :members, only: [:show, :edit, :update] do
      get :favorites, on: :collection
      get 'leave', on: :member
      patch 'withdrawal', on: :member
    end
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
end
