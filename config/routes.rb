Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post 'send_friend_request', to: 'friendships#create'
  put 'confirm_friend_request', to: 'friendships#update'
  delete 'reject_friend_request', to: 'friendships#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
