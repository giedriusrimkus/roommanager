Rails.application.routes.draw do

  resources :rooms
  get 'rooms', to: 'rooms#index'
  match 'rooms/:id/join', to: 'rooms#join', :via => :get, :as => :join_room
  match 'posts/:id/leave' => 'rooms#leave', :via => :get, :as => :leave_room

  match 'users/:id' => 'users#cancel_account', :via => :delete, :as => :cancel_account


  get 'rooms/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  resources :users

  get 'users/new'

  get  '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:new, :create, :edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  post   '/resend_activation/:email'  =>  'account_activations#resend_activation',
                                        :constraints => { :email => /[^\/]+/ }


  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
  
  get 'pages/home'

  get 'pages/about'

  resources :products #,          only: [:create, :destroy]

  root 'pages#home'


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
