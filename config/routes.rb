Rails.application.routes.draw do

  namespace :public do
    get 'members/show'
    get 'members/edit'
  end

  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    root 'homes#top'
    get 'homes/guideline' => 'homes#guideline'
    get "search_tag" => "posts#search_tag"
    resources :members, only: [:show, :edit, :update] do
      get :favorites, on: :collection
    end
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
end
