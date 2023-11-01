Rails.application.routes.draw do
  root to: 'items#index'
  namespace :items do
    resource :refresh, only: :update
  end

  namespace :api do
    namespace :v1 do
      resources :items, only: %i[index show] do
        collection do
          resource :refresh, only: %i[update], controller: 'items/refreshes'
        end
      end

      resource :contact, only: :create
      resources :quotes, only: :create
    end
  end
end
