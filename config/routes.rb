Rails.application.routes.draw do

  root 'homes#index'
  devise_for :users, controllers: { registrations: "users/registrations",  sessions: "users/sessions", passwords: "users/passwords", confirmations: "users/confirmations" }
  get 'theater_movies/:id',to: 'homes#theater_movies'
  get 'movie_theatres/:id', to: 'homes#movie_theatres'
  get 'all_theatres', to: 'homes#all_theatres'

  resources :theatres do
    resources :screens do
      resources :seats
      get 'screen_layout', to: 'bookings#screen_layout'
    end
  end

  resources :movies, controller: 'movies' do
    resources :shows, controller: 'shows' do
      resources :bookings, controller: 'bookings'
    end
  end

  resources :bookings, controller: 'bookings' do
    resources :tickets, controller: 'tickets'
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
