Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :transactions, only: [:create]
  resources :wallets, only: [:show]

  # Defines the root path route ("/")
  # root "posts#index"
    # Routes for sign in (new session) and sign out
  get    'login',  to: 'sessions#new'      # Display login form
  post   'login',  to: 'sessions#create'   # Handle login (sign in)
  delete 'logout', to: 'sessions#destroy'  # Handle logout (sign out)
  
  # Root path for testing
  root 'welcome#index'
end
