Rails.application.routes.draw do
    # Home
    root :to => 'pages#home'
    # Playlists
    put '/playlists/:id' => 'playlists#update', :as => 'update_playlist'
    resources :playlists, :only => [:index, :show, :new, :create, :destroy]
    # Albums
    resources :albums, :only => [:index, :show, :create, :destroy]
    # Artists
    resources :artists, :only => [:index, :show, :create, :destroy]
    # Users
    resources :users, :only => [:new, :create]
    # Songs
    resources :songs, :only => [:create, :destroy] do
        collection do
            put :add
        end
    end
    # Sessions
    get '/login' => 'session#new'
    post '/login' => 'session#create'
    delete '/login' => 'session#destroy'  
end
