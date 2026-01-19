Rails.application.routes.draw do
  get 'dashboard/index'
  get "/dashboard", to: "dashboard#index"
  get 'auth/index'
  resources :insurance_groups
  resources :insurance_contracts
  resources :coop_memberships do
    resources :insurance_contracts
    get 'get_cooperative', on: :collection
    get 'get_individual', on: :collection
  end
  resources :individuals do
        resources :insurance_contracts
  end
  namespace :agreement do
    resources :rates do
      get 'get_contract', on: :collection
    end
    resources :contracts do
      get 'get_cooperative', on: :collection
      get 'get_product', on: :collection
    end
  end
resources :cooperatives do
  get 'provinces_for_region', on: :collection
  get 'municipals_for_province', on: :collection
  get 'barangays_for_municipal', on: :collection
end

  resources :insurance_products
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  authenticated :user do
  root to: "dashboard#index", as: :authenticated_root
end

unauthenticated do
  root to: "auth#index", as: :unauthenticated_root
end

  # Defines the root path route ("/")
  # root "posts#index"
end
