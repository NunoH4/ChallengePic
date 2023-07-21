Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update]
    
    # get 'top' => 'homes#top', as: 'top'
    # get 'search' => 'homes#search', as: 'search'
    # get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
    # resources :customers, only: [:index, :show, :edit, :update]
    # resources :items, except: [:destroy]
    # resources :genres, only: [:index, :create, :edit, :update]
    # resources :orders, only: [:index, :show, :update] do
    #   resources :order_details, only: [:update]
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
