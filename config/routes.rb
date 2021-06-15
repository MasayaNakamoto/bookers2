Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
   resources :books, only: [:new, :create, :index, :show, :destroy, :edit]
   resources :users, only: [:index, :show, :edit, :update]
   post 'books/new'
   get 'homes/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
