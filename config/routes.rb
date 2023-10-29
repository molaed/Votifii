Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "elections#index"

  resources :elections do
    resources :candidates do
      #Here, makes the route: increment_votes_election_candidate_path
      member do
        patch 'increment_votes'
      end
    end
  end
end
