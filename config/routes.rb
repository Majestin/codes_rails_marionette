Codes::Application.routes.draw do

	root 'application#index'
	get 'box' => 'box#index'

	get 'box/all' => 'api#get_all_snippets', as: :get_all_snippets
	get 'box/:id' => 'api#get_snippets_by_id', as: :get_snippets_by_id
	get 'api/sources/:id' => 'api#get_sources_by_id', as: :get_sources_by_id

	# get 'box/tag/:id' => 'api#get_snippets_by_id', as: :get_snippets_by_id

	# get 'box/all' => 'api#get_all_snippets', as: :get_all_snippets

	# get     'box/snippet'     => 'api#snippet'
	# post    'box/snippet'     => 'api#new_snippet'
	# patch   'box/snippet/:id' => 'api#update_snippet'
	# put     'box/snippet/:id' => 'api#update_snippet'
	# delete  'box/snippet/:id' => 'api#delete_snippet'

	# post 'box/snippet' => 'api#update_snippet', as: :edit_snippet 

	get 'tags/:tag', to: 'snippets#index', as: :tag

	
	resources :categories
	resources :snippets do
		collection do
			get 'tags'
		end
	end
	resources :sources
	
	
	# resources :tags
	
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
