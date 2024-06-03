Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      get "/size_convert", to: "conversion#size_convert"
    end
  end

  resources :web_conversion, only: :index do
    collection do
      post :size_convert
    end
  end

  # Defines the root path route ("/")
  root "web_conversion#index"
end
