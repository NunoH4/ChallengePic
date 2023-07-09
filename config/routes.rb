Rails.application.routes.draw do
  
  # URL /customers/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    root 'homes#top'
    get 'homes/guideline' => 'homes#guideline'

    resources :posts, only: [:new, :index, :show, :edit]
  end
end
