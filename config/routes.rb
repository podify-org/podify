require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api"
  end
  post "/api", to: "graphql#execute"

  root to: 'vue_apps#main'
  devise_for :user, class_name: 'DeviseUser'

  resources :requests, only: %i[create]

  resources :sources, only: %i[index show] do
    resources :downloads, only: [] do
      member do
        get 'download', action: :serve, as: :serve
      end
    end
  end

  get 'rss/:token', to: 'feeds#show', as: :feed, constraints: { format: :rss }

  mount Downloads::FileUploader.download_endpoint => '/download'
  mount Sidekiq::Web => '/sidekiq'

  get '*path', to: 'vue_apps#main'
end
