# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    resources :dispensers, only: %i[new create destroy update show]
  end

  resources :dispensers, only: %i[index show update], defaults: { format: 'json' }
end
