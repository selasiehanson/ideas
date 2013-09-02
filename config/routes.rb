Ideas::Application.routes.draw do
  
  
  get "tasks/index"

  get "tasks/show"

  get "tasks/create"

  get "tasks/update"

  get "tasks/destroy"

  get "project_categories/index"

  get "project_categories/show"

  get "project_categories/create"

  get "project_categories/update"

  get "project_categories/destroy"

  get "projects/index"

  get "projects/show"

  get "projects/create"

  get "projects/update"

  get "projects/destroy"

  resources :users  
  root to: 'static_pages#home'
  resources :sessions , only: [:new, :create, :destroy]
  resources :project_categories, :only => [:index, :show, :edit]
  resources :projects do
    resources :notes , :only => [:index, :show, :edit]
    resources :tasks , :only => [:index, :show, :edit]
  end

  namespace :api do
    resources :project_categories, :only => [:index, :show,  :create, :update, :destroy]
    resources :projects do
      resources :notes, :only => [:index,:show, :create, :update, :destroy]
      resources :tasks, :only => [:index,:show, :create, :update, :destroy]
    end
  end

  match '/signin', to: 'sessions#new'
  match '/signout', to: "sessions#destroy", via: :delete
  match "/signup", to: "users#new"

  match '/home', to: "dashboard#show"
  # get '/tasks', to: "tasks#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
