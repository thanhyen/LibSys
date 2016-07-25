Rails.application.routes.draw do
  
  get '/users', to: 'user_management#index'
  

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    
  }
 root to: "home#index"
  get 'home/index'

  # 

  resources :books do
    member do
      get '/borrow_return', to: 'books#borrow_return'
    end
  end
  get 'books/cancel', to: 'books#cancel'
  get 'books/search/detail', to: 'books#search'
  
  
 
  # resources :user_management  
  # get '/user_management/:id/edit', to: "user_management#edit"
  resources :user_management, as: 'user', only: %w[ edit update destroy search show ] do
    member do
    end
  end

  resources :user_management, only: %w[ cancel_edit search ] do
    member do
      # patch 'update', to: 'user_management#update'
      # get 'edit', to: 'user_management#edit'
    end
    collection do
      get '/search', to: 'user_management#search'
      get '/cancel_edit', to: 'user_management#cancel_edit'
    end
  end

  # get '/user_management/:id/show', to: 'user_management#show', as: 'user'
   
  resources :authors

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
