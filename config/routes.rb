Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  resources :blog_posts

  # get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post
  
  # Defines the root path route ("/")
  root "blog_posts#index"
end
