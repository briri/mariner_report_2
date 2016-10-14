Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  
  root to: "news#index"

  resources :categories, only: [:index, :show]
  resources :publishers, only: [:index, :show]
end
