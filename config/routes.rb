Rails.application.routes.draw do

  namespace :api, :defaults => { :format => :json } do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  get '/', to: 'application#index', format: false
  get '/*path', to: 'application#index', format: false

end
