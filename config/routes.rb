Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :recipes do
    resources :doses

    resource :favorite, controller: 'recipes/favorites', only: :update
    resource :unfavorite, controller: 'recipes/unfavorites', only: :update
  end

  resources :dogs

  get '/dashboard', to: 'pages#dashboard'

  get '/recipe_book', to: 'pages#recipe_book'
end
