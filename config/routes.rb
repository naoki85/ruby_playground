Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Top
  get 'user_policy' => 'top#user_policy'
  get 'privacy_policy' => 'top#privacy_policy'

  # Book
  resources :books, only: [:index, :create, :destroy]
  get 'books/search' => 'books#search'
  get 'books/search_by_keyword' => 'books#search_by_keyword'

  # UserBook
  resources :user_books, only: [:index, :create, :destroy]

  # UserBookComment
  resources :user_book_comments, except: [:show]

  # View Routing Errors
  match '*path' => 'application#render_404', via: :all
end
