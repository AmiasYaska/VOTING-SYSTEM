Rails.application.routes.draw do
  get "positions/index"
  get "positions/show"
  get "positions/vote"
  devise_for :users, skip: [:registrations]

  resources :positions, only: [:index, :show] do
    member do
      post "vote"
    end
  end

  get "summary", to: "positions#summary", as: :summary
  post "submit_votes", to: "positions#submit_votes", as: :submit_votes
  get "thank_you", to: "positions#thank_you", as: :thank_you
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "positions#index"
end
