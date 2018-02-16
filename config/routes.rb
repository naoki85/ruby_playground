Rails.application.routes.draw do
  root 'top#index'
  devise_for :users

  # Top
  get 'search_books' => 'top#search_books'
  get 'search_books_by_keyword' => 'top#search_books_by_keyword'
  get 'user_policy' => 'top#user_policy'
  get 'privacy_policy' => 'top#privacy_policy'

  # UserBook
  resources :user_books, only: [:index, :create, :destroy]

  # HstUserReadBook
  resources :hst_user_read_books, except: [:show]

  # View Routing Errors
  match '*path' => 'application#render_404', via: :all
end
