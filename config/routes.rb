Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :recipes, except: [:destroy, :update, :create]
  resources :dogs, only: [:edit]
  resources :pages, only: [:dashboard]

end
