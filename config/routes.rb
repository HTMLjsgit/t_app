Rails.application.routes.draw do
  resources :real_comments
  get 'rooms/show'
  devise_for :users

  post 'users/restore/:id' => 'users#update_isstopped', as: 'users_restore'
  post 'users/stop/:id' => 'users#stop_isstopped', as: 'users_stop'


  resources :homes, only: [:show, :index]
  resources :users, only: [:show, :index, :create, :update, :edit]
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
  get  'users/:id/chat_index' => 'users#chat_index', as: 'chat_index'
  get  'users/:id/show_following' => 'users#show_following', as: 'show_following'
  get  'users/:id/show_follower' => 'users#show_follower', as: 'show_follower'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  patch 'users/avater_update' => 'users#avater_update', as: 'avater_update'
  patch 'users/bank_update' => 'users#bank_update', as: 'bank_update'
  post 'rooms/:to_user_id' => 'rooms#create'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :rooms, only: [:show] # チャットルームの表示
      if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
end
