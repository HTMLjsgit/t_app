Rails.application.routes.draw do


  get 'rooms/show'
  devise_for :users

  resources :users, only: [:show, :index]
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get  'users/:id/chat_index' => 'users#chat_index', as: 'chat_index'
  get  'users/:id/show_following' => 'users#show_following', as: 'show_following'
  get  'users/:id/show_follower' => 'users#show_follower', as: 'show_follower'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  patch 'users/avater_update' => 'users#avater_update', as: 'avater_update'

  post 'rooms/:to_user_id' => 'rooms#create'

  resources :rooms, only: [:show] # チャットルームの表示
      if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
end