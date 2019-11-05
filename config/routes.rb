Rails.application.routes.draw do
    # Home
    root :to => 'pages#home'
    # Playlists
    resources :playlists, :only => [:index, :show, :new, :create]
    # Albums
    resources :albums, :only => [:index, :show, :new, :create]
    # Artists
    resources :artists, :only => [:index, :show, :new, :create]
    # Users
    resources :users, :only => [:new, :create]
    # Songs
    resources :songs, :only => [:create]
    # Sessions
    get '/login' => 'session#new'
    post '/login' => 'session#create'
    delete '/login' => 'session#destroy'  
end
