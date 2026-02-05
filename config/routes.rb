Rails.application.routes.draw do
  get 'permissions/edit'
  get 'permissions/update'
  resources :dependents
  resources :relationships
  resources :branch_offices
  resources :territories
  resources :producers
  resources :departments
  resources :roles do
    resource :permissions, only: [:edit, :update]
  end
  resources :types
  resources :employees
  resources :registries
  resources :branches
  resources :add_barangays
  resources :add_provinces
  resources :add_municipals
  resources :add_regions
  get 'dashboard/index'
  get "/dashboard", to: "dashboard#index"
  get 'auth/index'
  resources :insurance_groups do
  resources :insurance_contracts, only: [:new, :create]
  end
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
    resources :eligibilities do
    resources :perils, only: [:new, :create, :index, :edit, :update, :destroy, :show]
    end
    resources :perils, only: [:index]
    resources :rates do
      get 'get_contract', on: :collection
    end
    resources :contracts do
      collection do
        get :products_for_type
      end
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
    devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
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
  get 'cooperatives/provinces_for_region', to: 'cooperatives#provinces_for_region'
get 'cooperatives/municipals_for_province', to: 'cooperatives#municipals_for_province'
get 'cooperatives/barangays_for_municipal', to: 'cooperatives#barangays_for_municipal'
end
