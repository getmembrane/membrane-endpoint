Rails.application.routes.draw do
    scope module: "api", as: "api" do
        namespace :v1, defaults: { format: :json } do
            resource :ping, only: [:show]
            resources :clients, only: [:create, :show, :update]
            resources :users, only: [:index, :create, :show, :update, :destroy]

            get "docs.json", to: "docs#index"
        end

        get "docs(/:action)", controller: :docs, defaults: { action: "index" }
    end

    match "/400", to: "errors#bad_request", via: :all
    match "/404", to: "errors#file_not_found", via: :all
    match "/500", to: "errors#internal_server_error", via: :all

end
