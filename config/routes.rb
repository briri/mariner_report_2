Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations',
    passwords: 'passwords'
    #sessions: 'sessions'
  }

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    delete '/logout' => 'devise/sessions#destroy'
  end
  
#  devise_for :users, :controllers => {:registrations => "registrations", 
#    :confirmations => 'confirmations', :passwords => 'passwords', 
#    :sessions => 'sessions', :omniauth_callbacks => 'users/omniauth_callbacks'} do
#    get "/users/sign_out", :to => "devise/sessions#destroy"
#  end
  
  root to: 'news#index'

  # Static public facing pages
  get '/about',     to: 'statics#about'
  get '/advertise', to: 'statics#advertise'
  get '/terms',     to: 'statics#terms'

  get '/explore',   to: 'statics#explore'

  resources :contacts, only: [:index, :new, :create]

  resources :categories, only: [:index, :show]

  resources :publishers, only: [:index, :show, :edit, :update, :new, :create] do
    resources :feeds, only: [:edit, :update, :new, :create]
  end
end
