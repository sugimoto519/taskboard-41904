Rails.application.routes.draw do
  root to: "tasks#index"
  devise_for :users
  resources :tasks do 
    member do 
      patch :toggle_completion
    end 
    collection do 
      get 'today'
      get 'week'
      get 'completed'
    end
  end
end
