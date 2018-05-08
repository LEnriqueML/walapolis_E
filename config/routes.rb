Rails.application.routes.draw do
  resources :comments, except: [:index, :show]
  # resources :likes
  resources :ideas
  devise_for :users, controllers: {
    # confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    # unlocks: 'users/unlocks'
  }

  devise_scope :user do
  	get 'entrar', to: 'users/sessions#new', as: :entrar
  	get 'registro', to: 'users/registrations#new', as: :registro
    get '/perfiles/:user_id', to: 'users/registrations#profile', as: :profile
  end


  root to: 'static_pages#home'
  post '/likes/tgol/:user_id/:idea_id', to: 'likes#the_god_of_likes', as: :tgol
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
