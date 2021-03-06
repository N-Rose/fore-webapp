Rails.application.routes.draw do

namespace :admin do
  post "search", to: "search#search", as: 'search'
  resources :holes
  resources :score_cards
  resources :amenities
  resources :networks
  resources :resorts
  resources :locations
  resources :courses
  get "users/index"
  post "videos/create", to: 'videos#create' ,as: 'video_create'
  get "videos/:id" , to: 'videos#show' ,as: 'video'
  post "tags/:video_id/save" ,to: 'tags#create', as: 'create_tag'
  delete "tags/:id" ,to: 'tags#destroy', as: 'delete_tag'
  post "holes/add_image" ,to: 'holes#add_image', as: 'add_image'
end

  devise_for :admins
  devise_for :users
  # put '/users', :to => 'devise/registrations#update', :as => :update_user
  namespace :v1, defaults: {format: :json} do
    delete '/sessions', :to => 'sessions#destroy'
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :pages, only: [:index]
    resources :courses, only:[:index,:show]
    resources :users, only:[:show, :update]
    resources :videos, only:[:show]
    resources :lists, only: [:create, :show]
    resources :reviews, only: [:show]
    resources :scores, only: [:create, :show]
    post "lists/:id/add_course", to: 'lists#add_course', as: 'add_course'
    post "courses/:id/add_user", to: 'courses#add_user', as: 'add_user'
    get "users/:id/lists" , to: 'users#lists', as: 'user_lists'
  end

  root to: "admin/courses#new"

  namespace :embed do
    resources :pages, only: :show, path: "" # -> domain.com/embed/1
  end
end
