Rails.application.routes.draw do
  namespace :admin do
      resources :impressions
      resources :users
      resources :transfer_requests
      resources :chat_posts
      resources :comments
      resources :image_posts
      resources :image_reals
      resources :likes
      resources :posts
      resources :reals
      resources :relationships
      resources :rooms
      resources :payments
      resources :user_rooms
      resources :post_thumbnails
      resources :sales
      resources :transfer_completions
      root to: "impressions#index"
    end
  resources :real_comments
  devise_for :users

  post 'users/restore/:id' => 'users#update_isstopped', as: 'users_restore'
  post 'users/stop/:id' => 'users#stop_isstopped', as: 'users_stop'
  resources :transfer_completions, only: [:update]
  resources :homes, only: [:show, :index]
  resources :users, only: [:index, :create, :update, :edit]
  resources :users, only: [:show] do
    resources :rooms, only: [:index, :create]
    resources :sales
    resources :transfer_requests, only: [:create]
    member do
      put :bank_update
      put :avater_update
    end
  end
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    member do
      # 記事の説明ページ
      get :post_explanation
    end
    #--------支払い履歴Routes--------------

    #postsの子として追加することで  /posts/:id/payments が実現可能になる。
    resources :payments, only: [:index] do
      collection do

        #posts(記事)を購入した場合のroutes

        post :post_payment
      end
    end

    #---------------------
  end
  resources :comments, only: [:new, :create, :show, :destroy]
  resources :reals, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    post 'like/:id' => 'likes#create', as: 'create_like'
    delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
    post 'real_like/:id' => 'real_likes#create', as: 'create_real_like'
    delete 'real_like/:id' => 'real_likes#destroy', as: 'destroy_real_like'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get  'users/:id/show_following' => 'users#show_following', as: 'show_following'
  get  'users/:id/show_follower' => 'users#show_follower', as: 'show_follower'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :rooms, only: [:show, :create] # チャットルームの表示
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
