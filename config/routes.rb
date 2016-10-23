Rails.application.routes.draw do
    namespace :api, defaults: { format: :json } constraints: { subdomain: 'api' }, path: '/' do
        scope module :v1 do
            resource :ping, only: [:show]
            resources :clients, only: [:create, :show, :update]
            resources :reports, only: [:create, :destroy]
            resources :users, only: [:index, :create, :show, :update, :destroy]

            get "docs.json", to: "docs#index"
        end

        match "/400", to: "errors#bad_request", via: :all
        match "/404", to: "errors#file_not_found", via: :all
        match "/500", to: "errors#internal_server_error", via: :all

        get "docs(/:action)", controller: :docs, defaults: { action: "index" }
    end
end
