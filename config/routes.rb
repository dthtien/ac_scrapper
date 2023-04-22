Rails.application.routes.draw do
  root to: 'items#index'
  namespace :items do
    resource :refresh, only: :update
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
