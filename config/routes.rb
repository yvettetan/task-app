Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'
  resources :categories do
    resources :tasks
  end
end
