Rails.application.routes.draw do
  get 'tasks/index'
  root to: "tasks#index"
  devise_for :users
  resources :tasks

end
