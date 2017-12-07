Rails.application.routes.draw do

  namespace :api, :defaults => { :format => :json } do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/me', to: 'sessions#me'

    patch '/user', to: 'users#update'

    get '/wishes', to: 'wishes#index'
    post '/wishes', to: 'wishes#create'
    delete '/wishes/:id', to: 'wishes#destroy'


    get '/universities', to: 'universities#index'
    get '/search-universities', to: 'universities#search_universities'
    get '/universities/:code/branches', to: 'universities#branches'

    get '/branches', to: 'universities#list_branches'
    get '/recommend', to: 'universities#recommend'

  end

  get '/', to: 'application#index', format: false
  get '/*path', to: 'application#index', format: false

end
