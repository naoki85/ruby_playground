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
    post 'posts/upload' => 'posts#upload'
    get 'posts/ogp' => 'posts#ogp'
    resources :posts, only: [:index, :show]
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
