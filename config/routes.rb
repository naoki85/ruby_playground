Rails.application.routes.draw do
  root 'admin/sessions#new'
  get 'sign_up' => 'admin/users#new'
  post 'sign_up' => 'admin/users#create'
  get 'sign_in' => 'admin/sessions#new'
  post 'sign_in' => 'admin/sessions#create'
  delete 'sign_out' => 'admin/sessions#destroy'
  get 'user_policy' => 'policies#user_policy'
  get 'privacy_policy' => 'policies#privacy_policy'
  get 'health_check' => 'api_application#health_check'
  resources :posts, only: [:show]

  # API
  namespace :v1, format: 'json' do
    post 'posts/upload' => 'posts#upload'
    get 'posts/ogp' => 'posts#ogp'
  end

  # Admin
  namespace :admin do
    resources :posts
    resources :post_categories, except: [:show]
    resources :recommended_books
    get 'me' => 'users#show'
    get 'me/edit' => 'users#edit'
    patch 'me' => 'users#update'
  end

  # View Routing Errors
  # match '*path' => 'application#render_404', via: :all
end
