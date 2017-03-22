Rails.application.routes.draw do
  get '/parse', to: 'pages#parse'
  get '/index', to: 'pages#index'
end
