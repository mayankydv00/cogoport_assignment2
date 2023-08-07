Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
   
 namespace :api do
      resources :users
      get 'users/:id/followers', to: 'users#followers'
    get 'users/:id/following', to: 'users#following'
    end
  

  namespace :api do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  
    namespace :api do
      resources :posts
    end

    namespace :api do
      resources :follows 
    end
 
    namespace :api do
      resources :comments
    end

    namespace :api do
      resources :likes
    end
    
  
    namespace :api do
      resources :comments do
        get 'for_post/:post_id', action: :comments_for_post, on: :collection
      end
    end
    
  
  
end
