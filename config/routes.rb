Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users,
    defaults: { format: :json },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  # Custom API-friendly endpoints
  devise_scope :user do
    post   "/login",    to: "users/sessions#create"
    delete "/logout",   to: "users/sessions#destroy"
    post   "/signup",   to: "users/registrations#create"
  end

  resources :books
  resources :borrowings, only: [ :create, :update, :index ]

  root "books#index"
end
