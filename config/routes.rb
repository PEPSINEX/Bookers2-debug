Rails.application.routes.draw do
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :following
      get :follower
    end
  end
  resources :favorite_from_user_to_books, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end