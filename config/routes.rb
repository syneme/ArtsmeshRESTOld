ActionController::Routing::Routes.draw do |map|
  map.resources :users

  map.resources :scripts

  map.resources :artists

  map.resources :rooms

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  #map.connect 'rooms.:format',:controller=>'rooms',:action=>'destroy',:member=>:delete
  
  map.connect 'rooms.:format',:controller=>'rooms',:action=>'create',:member=>:post
  map.connect 'rooms/:id.:status.:format',:controller=>'rooms',:action=>'show',:member=>:get
  #map.connect 'rooms/:id.remove.:format',:controller=>'rooms',:action=>'show',:member=>:get
  #map.connect 'rooms/:id.delete.:format',:controller=>'rooms',:action=>'show',:member=>:get
  map.connect 'artists.:format',:controller=>'artists',:action=>'create',:member=>:post
  #map.connect 'artists/:id',:controller=>'artists',:action=>'show',:member=>:get
  map.connect 'artists/:id.:status.:format',:controller=>'artists',:action=>'show',:member=>:get
  map.connect 'scripts/server/:id.:format',:controller=>'scripts',:action=>'server',:member=>:get
  map.connect 'scripts/client/:id.:format',:controller=>'scripts',:action=>'client',:member=>:get
  map.connect 'users.:format',:controller=>'users',:action=>'create',:member=>:post
  map.connect 'users/:id.:status.:format',:controller=>'users',:action=>'show',:member=>:get
  #map.connect 'users/:id.delete.xml',:controller=>'users',:action=>'show',:member=>:get
end
