Rails.application.routes.draw do
  root to: 'items#index'
  namespace :items do
    resource :refresh, only: :update
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index] do
        collection do
          resource :refresh, only: :update, controller: 'items/refreshes'
        end
      end

      resource :contact, only: :create
    end
  end
end
