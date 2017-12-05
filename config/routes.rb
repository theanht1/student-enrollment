Rails.application.routes.draw do

  get '/login', to: 'sites#login'

  namespace :api, :defaults => { :format => :json } do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
