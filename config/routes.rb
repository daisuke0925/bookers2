Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users

  resources :books, only: [:update, :create, :index, :show, :destroy, :edit]

  get 'home/about'=> "homes#about"


  resources :users, only:[:uodate, :index, :show, :edit]

end