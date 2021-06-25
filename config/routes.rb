Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
   resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit]
   resources :users, only: [:index, :show, :edit, :update, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
