Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root to: "pages#home"

  post '/message' => 'messages#create'
  get '/login' => "session#new"
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :rooms
  resources :messages
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
