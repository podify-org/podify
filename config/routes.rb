Rails.application.routes.draw do
  root to: 'sources#index'
  resources :sources
end
