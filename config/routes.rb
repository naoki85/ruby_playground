Rails.application.routes.draw do
  root 'web#index'
  get 'sign_in' => 'web#index'

  get 'user_policy' => 'web#index'
  get 'privacy_policy' => 'web#index'

  get 'users/edit' => 'web#index'
  get 'users/:id' => 'web#index'
  get 'books/search' => 'web#index'
  get 'books/:id' => 'web#index'
  get 'publishers/:id' => 'web#index'

  get 'posts/new' => 'web#index'
  get 'posts/edit/:id' => 'web#index'
  resources :posts, only: [:index, :show]

  # API
  namespace :v1, format: 'json' do
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get 'me' => 'users#me'
    resources :users, only: [:show, :create, :update]
    resources :user_books, only: [:index, :create]
    delete 'user_books' => 'user_books#destroy'
    get 'books/search' => 'books#search'
    resources :books, only: [:index, :show]
    resources :publishers, only: [:index, :show]
    resources :posts, only: [:index, :show, :create, :update, :destroy]
  end

  # View Routing Errors
  # match '*path' => 'application#render_404', via: :all
end
