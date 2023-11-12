Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "elections#home"
  resource :user, only: [:show, :edit, :update]
  resources :users
  resources :elections do
    member do
      get 'end'
      get 'archived', to: 'elections#archived'
    end
    resources :candidates do
      #Here, makes the route: increment_votes_election_candidate_path
      member do
        patch 'increment_votes'
      end
    end
  end

  #routes.rb
  match 'users/:id' => 'users#show', via: :get
  # or
  get 'users/:id' => 'users#show'
  # or
  resources :users, only: [:show]

end
