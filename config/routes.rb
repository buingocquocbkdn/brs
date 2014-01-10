Brs::Application.routes.draw do
  root to:  'static_pages#home'
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  #resources :users
  get "users/new"
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signin',  to: 'sessions#new',         via: 'get'

  #match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :books do
    resources :rates, only: [:create, :destroy, :update, :edit]
    resources :favourites, only: [:create]
    resources :buys, only: [:create, :destroy]
    resources :reviews
  end

  resources :users do
    resources :favourites, only: [:index]
    resources :buys, only: [:index]
    member do
      get :following, :followers
    end
  end
  resources :readings, only: [:index, :create]
  resources :reads, only: [:create]
  resources :searchs
  resources :likes, only: [:create, :destroy]

  namespace :admin do
    root to: 'books#index'
    resources :books
    resources :users
    resources :buys, only: [:index, :update, :destroy]
    match 'buys/:id/:request', to: 'buys#update', as: 'buy_request', via: 'patch'

    resources :sessions, only: [:new, :create, :destroy]
    match 'signout', to: 'sessions#destroy',     via: 'delete'
    match 'signin',  to: 'sessions#new',         via: 'get'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
