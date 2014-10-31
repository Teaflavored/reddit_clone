Rails.application.routes.draw do
  resources :users, except: [:index, :destroy, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  
  resources :subs
  resources :posts, except: [:index, :destroy]
end
