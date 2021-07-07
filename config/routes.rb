Rails.application.routes.draw do
  get 'chats/show'
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "search" => "searchs#search"
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

   resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
       resource :favorites, only: [:create, :destroy]
       resources :book_comments, only: [:create, :destroy]
       get 'search'
   end

   resources :users, only: [:index, :show, :edit, :update, :create] do
        resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
        get 'search' => 'users#search'
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
