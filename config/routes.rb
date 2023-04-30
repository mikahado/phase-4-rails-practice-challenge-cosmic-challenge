Rails.application.routes.draw do
  resources :planets, only: [:index]
  resources :missions, only: [:create]
  resources :scientists

  get '/search-planet/:search', to: 'planets#search'

  get '/pluto_specialists', to: 'scientists#pluto'
  get '/pluto_specialists_mission', to: 'scientists#pluto_missions'
  get '/mission_length', to: 'missions#length'
  get '/long-search/:days', to: 'missions#search_length'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
