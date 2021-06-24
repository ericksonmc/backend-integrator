Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :auth, only: [:create] do
        post :auto_login, on: :collection
        get :auto_login, on: :collection
      end
      resources :sales, only: [:create]

      resources :reports, only: [] do 
        get :lotery_results, on: :collection
        get :consult_tickets, on: :collection
      end
    end
    
  end
end
