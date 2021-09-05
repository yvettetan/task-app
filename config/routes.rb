Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, path: '', path_names: { sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}
  get 'tasks/index'
  resources :categories do
    resources :tasks, except: :index do
      member do
        patch :complete
        patch :undo
      end 
    end
  end
  resources :tasks, only: :index do
    member do
      patch :complete
      patch :undo
    end 
  end
end
