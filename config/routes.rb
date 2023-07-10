Rails.application.routes.draw do
  
  namespace :public do
    get 'members/show'
    get 'members/edit'
  end
  # URL /customers/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    root 'homes#top'
    get 'homes/guideline' => 'homes#guideline'

    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update]
    get "search_tag" => "posts#search_tag"
  end
end
