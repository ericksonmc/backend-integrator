Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        post :login, on: :collection
        get :auto_login, on: :collection
      end
    end
  end
end
