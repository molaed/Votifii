Rails.application.routes.draw do
  # Configures Devise routes for user authentication
  devise_for :users

  # Defines the root path route ("/") to the home action in the ElectionsController
  root "elections#home"
  resource :user, only: [:show, :edit, :update]
  resources :users

  # Defines RESTful routes for elections and nested routes for candidates
  resources :elections do
    member do
      # Custom member routes for specific actions like 'end' and 'archived'
      get 'end'
      get 'archived', to: 'elections#archived'
    end

    # Nested routes for candidates within elections, including a custom route for incrementing votes
    resources :candidates do
      member do
        patch 'increment_votes'
      end
    end
  end

  # Defines a route for displaying user profiles
  resources :users, only: [:show]
  # or alternatively, the following equivalent routes:
  # match 'users/:id' => 'users#show', via: :get
  # get 'users/:id' => 'users#show'
  resources :users do
    resources :elections do
      resources :candidates do
        resources :comments, only: [:create, :destroy]
      end
    end
  end

end
