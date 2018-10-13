Rails.application.routes.draw do
  root 'posts#index'
  get 'sign_in' => 'admin/sessions#new'
  post 'sign_in' => 'admin/sessions#create'
  delete 'sign_out' => 'admin/sessions#destroy'

  get 'users/edit' => 'web#index'

  get '/posts', to: redirect('/')
  get 'posts/new' => 'web#index'
  get 'posts/edit/:id' => 'web#index'
  resources :posts, only: [:show]
  get :feed, to: 'rss#index', defaults: { format: :rss }

  get 'user_policy' => 'policies#user_policy'
  get 'privacy_policy' => 'policies#privacy_policy'

  # API
  namespace :v1, format: 'json' do
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get 'me' => 'users#me'
    resources :users, only: [:show, :create, :update]
    resources :books, only: [:index, :show]
    resources :publishers, only: [:index, :show]
    post 'posts/upload' => 'posts#upload'
    resources :posts, only: [:index, :show, :create, :update, :destroy]
    resources :book_categories, only: [:index]
  end

  # Admin
  namespace :admin do
    resources :posts
    resources :post_categories, except: [:show]
    get 'me' => 'users#show'
    get 'me/edit' => 'users#edit'
    patch 'me' => 'users#update'
  end

  # View Routing Errors
  # match '*path' => 'application#render_404', via: :all
end
