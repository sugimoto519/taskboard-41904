Rails.application.routes.draw do
  root to: "tasks#index"
  devise_for :users
  resources :tasks do 
    resources :comments, only: [:create, :edit, :update, :destroy]
    member do 
      patch :toggle_completion
    end 
    collection do 
      get 'today'
      get 'week'
      get 'completed'
    end
  end
  resources :teams do 
    resources :team_users, only: [:create, :destroy]
  end
end
