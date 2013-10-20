Whitehat::Application.routes.draw do
  root 'home#index'
  
  get '/login',  :to => 'sessions#new',     :as => 'login'
  get '/logout', :to => 'sessions#destroy', :as => 'logout'

  match '/auth/:provider/callback', :to => 'sessions#create', :via => [:get, :post]
  match '/auth/failure',            :to => 'sessions#failure', :via => [:get, :post]

  resources :issues
end
