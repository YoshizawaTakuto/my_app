Rails.application.routes.draw do
  post "likes/:id/create" => "likes#create"
  post "likes/:id/destroy" => "likes#destroy"

  get "/" => "posts#index"

  get "users/:id/likes" => "users#likes"
  get "login_form" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  resources :users
  resources :posts, expect: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
