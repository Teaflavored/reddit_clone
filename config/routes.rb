Rails.application.routes.draw do
  resources :users, except: [:index, :destroy, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  
  resources :subs
  resources :posts, except: [:index, :destroy] do 
    resources :comments, only: :new
    get "upvote", "downvote"
  end
  
  resources :comments, only: [:create, :show] do
    get "upvote", "downvote"
  end
end
