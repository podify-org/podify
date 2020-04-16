Rails.application.routes.draw do
  root to: 'sources#index'
  resources :sources

  get 'feed/:collection', to: 'feeds#show', constraints: { format: :rss }
end
