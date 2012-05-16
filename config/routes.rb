RebelFoundation::Application.routes.draw do
  resources :users do
    put 'update_password'
    resources :providers, controller: 'users/providers'
  end
  resources :checkins
  resources :venues
end
