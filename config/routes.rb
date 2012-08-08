Qbapp::Application.routes.draw do

  root :to => 'pages#home'
  get '/dashboard' => 'pages#dashboard', as: :dashboard
  get '/SendOpenIDRequest' => 'sessions#request_id'
  

end
