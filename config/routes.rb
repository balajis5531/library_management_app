Rails.application.routes.draw do
  get 'index/index'
  
 root to: "index#index"
  resources :users

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  resources :books

  get '/books', to: 'books#index'
  post '/book', to: 'books#create'

  resources :books do
    post 'borrow', to: 'borrows#create', on: :member
  end

  resources :books do
    patch 'return_book', to: 'borrows#return_book', on: :member
  end

  resources :borrows do
    patch 'lose', to: 'borrows#lose_book', on: :member
  end

  resources :books do
    member do 
      get 'admin_access'
    end
  end

  resources :users do
    member do 
      get 'borrowed_book'
    end
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  get '/search', to: 'books#search', as: 'search_books'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
