Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # Source: http://hibbard.eu/authentication-with-devise-and-cancancan-in-rails-4-2/
  authenticated :user do
    root :to => 'questions#index', as: :authenticated_root
  end
  root :to => 'static#welcome' 

  ### ADD THIS IN! ###
  # %w[about privacy license].each do |page|
  #   get page, controller: "info", action: page
  # end




  # You can have the root of your site routed with "root"
  # root 'questions#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :questions do
    resources :answers, only: [ :edit, :create, :destroy ] do
      member { post :vote, :unvote }
    end
    collection do
      get 'search'
    end
  end

  resources :users, only: [ :show ]
  resources :dashboard, only: [:index]

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
