Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace "api" do
    namespace "v1" do
      resources :bonds
      get 'bonds', to: 'bonds#index'
      get 'bonds/:id', to: 'bonds#show'
      post 'bonds', to: 'bonds#create'
      put 'bonds/:id', to: 'bonds#update'
      delete 'bonds/:id', to: 'bonds#delete'
      get 'my_bonds', to: 'bonds#user_bonds'
      get 'bonds_for_buy', to: 'bonds#bonds_for_buy'
      put 'buy_bond/:id', to: 'bonds#buy_bonds'
    end
  end
end
