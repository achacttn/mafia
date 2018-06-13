Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root to: "pages#home"

  # post '/message' => 'messages#create'
  post '/mafia/:id' => 'mafias#create'
  # post '/rooms/:id' => 'messages#create'
  # post '/rooms/:id/messages' => 'rooms#messages', as: :messages_room
  get '/login' => "session#new"
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :mafias
  resources :rooms
  resources :messages
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
