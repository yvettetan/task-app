Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :categories do
    resources :tasks, except: :index
  end
  resources :tasks, only: :index
end
