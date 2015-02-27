Rails.application.routes.draw do

  get "users/sign_in" => redirect('/users/auth/github'), via: [:get, :post]
  get "users/sign_up" => redirect('/users/auth/github'), via: [:get, :post]

  # devise_for  :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",  registrations: "users"}

  root        to: "pages#index"

  namespace :users do
    resources :after_signup
  end

  resources   :users
  get         "/users/unsubscribe/:account_delete_token" => "users#token_delete", as: :token_delete_user
  delete      "/users/unsubscribe/:account_delete_token" => "users#token_destroy"

  resources   :issue_assignments

  get "/issue_assignments/:id/users/:user_id/click", to: "issue_assignments#click_redirect", as: :issue_click

  resources   :repo_subscriptions

  if Rails.env.development?
    # mount UserMailer::Preview => 'mail_view'
  end

  # mount Resque::Server.new, at: "/codetriage/resque"

  # format: false gives us rails 3.0 style routes so angular/angular.js is interpreted as
  # user_name: "angular", name: "angular.js" instead of using the "js" as a format

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
