Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews do
      resources :reviews_comment, only: [:destroy]
    end
    get 'homes/top'
  end


  # ゲストログイン用path
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
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

  namespace :public do
    resources :reviews do
      resources :reviews_comment, only: [:create, :destroy]
    end
  end

  resources :reviews do
    get :search, on: :collection
  end

  root to: 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
