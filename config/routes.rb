Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  
  root to: 'news#index'

  # Static public facing pages
  get '/about',     to: 'statics#about'
  get '/advertise',  to: 'statics#advertise'
  get '/terms',     to: 'statics#terms'

  resources :contacts, only: [:index, :new, :create]

  resources :categories, only: [:index, :show]
  resources :publishers, only: [:index, :show]
end
