Rails.application.routes.draw do
  root 'top#index'
  devise_for :users

  # Top
  get 'search_books' => 'top#search_books'
  get 'search_books_by_keyword' => 'top#search_books_by_keyword'
end
