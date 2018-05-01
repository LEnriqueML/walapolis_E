Rails.application.routes.draw do
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
  end

  root to: 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
