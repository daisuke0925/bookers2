Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :destroy]

  get 'home/about'=> "homes#about"


  resources :users, only:[:create, :index, :show, :destroy]

end