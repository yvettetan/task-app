Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}
  root 'tasks#index'
  resources :categories do
    resources :tasks, except: :index
  end
  resources :tasks, only: :index
end
