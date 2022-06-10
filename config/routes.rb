Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  end
  namespace :admin do
    resources :reviews do  #postsコントローラへのルーティング
      resources :reviews_comment, only: [:destroy]  #commentsコントローラへのルーティング
    end
  end
  namespace :admin do
    get 'homes/top'
  end


  # 顧客用
  # URL /customers/sign_in ...
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  get 'users/quit' => 'public/users#quit', as: 'public_users_quit'
  # 論理削除用のルーティング
  patch 'users/:id/withdrawal' => 'public/users#withdrawal', as: 'public_withdrawal'
  get 'users/:id/edit' => 'public/users#edit', as: 'edit_public_user'
  patch 'users/:id' => 'public/users#update', as: 'public_user'
  get 'users/:id' => 'public/users#show'


  get 'reviews/new' => 'public/reviews#new', as: 'new_public_reviews'
  get 'reviews' => 'public/reviews#index', as: 'public_reviews'
  post 'reviews' => 'public/reviews#create'
  get 'reviews/:id/edit' => 'public/reviews#edit', as: 'edit_public_review'
  patch 'reviews/:id' => 'public/reviews#update', as: 'public_review'
  delete 'reviews/:id' => 'public/reviews#destroy'
  get 'reviews/:id' => 'public/reviews#show'

  #post 'reviews/:review_id/reviews_comment' => 'public/reviews_comment#create', as: 'reviews_comment'
  #delete 'reviews_comment/:id' => 'public/reviews_comment#destroy', as: 'comment_delete'

  namespace :public do
    resources :reviews do  #postsコントローラへのルーティング
      resources :reviews_comment, only: [:create, :destroy]  #commentsコントローラへのルーティング
    end
  end



  root to: 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
