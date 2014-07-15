Rails.application.routes.draw do

  root 'queries#index'

  resources :queries do
    resources :tweets, only: %i(index)
  end
end