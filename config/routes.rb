Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/guideline' => 'homes#guideline'
  
  # URL /customers/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
end
