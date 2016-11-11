require 'api_constraints'

Rails.application.routes.draw do

    #API routes
    namespace :api, defaults: { format: :json },
                constraints: { subdomain: 'api' }, path: '/' do
        scope module: :v1,
            constraints: ApiConstraints.new(version: 1, default: true) do

            resource :ping, only: [:show]
            resources :sessions, only: [:create]
            resources :clients, only: [:create, :show, :update]
            resources :reports, only: [:create, :destroy]
            resources :users, only: [:create, :show, :destroy]

            get "docs.json", to: "docs#index"
        end

        match "/400", to: "errors#bad_request", via: :all
        match "/404", to: "errors#file_not_found", via: :all
        match "/500", to: "errors#internal_server_error", via: :all

        get "docs(/:action)", controller: :docs, defaults: { action: "index", format: :html }
    end

    root "home#index"
end
