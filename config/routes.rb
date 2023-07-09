Rails.application.routes.draw do

  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  
  # URL /customers/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    root 'homes#top'
    get 'homes/guideline' => 'homes#guideline'

    
  end
end
