Qbapp::Application.routes.draw do

  root :to => 'pages#home'
  
  get '/dashboard' => 'pages#dashboard', as: :dashboard
  
  get '/oauth_request' => 'sessions#oauth_request'
  
  get '/oauth/callback' => 'sessions#callback'
  
  get '/signout' => 'sessions#destroy', as: :signout

end
