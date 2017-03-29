Rails.application.routes.draw do
  # Pages
  root              to: 'pages#root'
  post '/parse',    to: 'pages#create'
  get '/index',     to: 'pages#index'
  get '/show',      to: 'pages#show'

  # Sessions
  post '/sessions', to: 'sessions#signup', constraints: CommitParamRouting.new(SessionsController::SIGNUP)
  post '/sessions', to: 'sessions#login', constraints: CommitParamRouting.new(SessionsController::LOGIN)
  delete '/logout', to: 'sessions#destroy'
end
