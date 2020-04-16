Rails.application.routes.draw do
  root to: 'sources#index'

  resources :sources, only: %i[index show create] do
    resources :downloads, only: [] do
      member do
        get 'download', action: :serve, as: :serve
      end
    end
  end

  get 'feed/:collection', to: 'feeds#show', constraints: { format: :rss }
end
