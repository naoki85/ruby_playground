Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: :show

  # Top
  get 'user_policy' => 'top#user_policy'
  get 'privacy_policy' => 'top#privacy_policy'

  # Book
  get 'books/search' => 'books#search'
  resources :books, only: [:index, :show, :create, :destroy]

  # UserBook
  resources :user_books, only: [:index, :create]

  # UserBookComment
  resources :user_book_comments, except: [:show]

  # Publisher
  resources :publishers, only: [:show]

  # API
  namespace :v1, format: 'json' do
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get 'user/account' => 'users#account'
    resources :users, only: [:show, :create, :update]
    resources :user_book_comments, only: [:index, :create, :update, :destroy]
    resources :user_books, only: [:create]
    delete 'user_books' => 'user_books#destroy'
    get 'books/search' => 'books#search'
    resources :books, only: [:show]
  end

  # View Routing Errors
  # match '*path' => 'application#render_404', via: :all
end
