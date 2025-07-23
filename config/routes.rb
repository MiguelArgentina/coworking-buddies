Rails.application.routes.draw do
  devise_for :users

  # Publicly accessible routes
  root to: "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :places, only: [:index] do
    resources :votes, only: [:create]
    end

  resources :events, only: [:index] do
    resources :event_comments, only: [:create]
    resources :event_participations, only: [:create, :destroy]
  end



  namespace :locations do
    get "lookups/geocode", to: "lookups#geocode"
    get "lookups/states", to: "lookups#states"
    get "lookups/cities", to: "lookups#cities"
  end
  # Authenticated-only routes
  authenticate :user do
    resources :places, except: [:index]
    resources :events, except: [:index] do
      resource :event_participation, only: [:create, :destroy]
    end


    namespace :locations do
      get "states", to: "lookups#states"
      get "cities", to: "lookups#cities"
    end
  end
end
