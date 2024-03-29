RebelFoundation::Application.routes.draw do
  resources :users do
    put 'update_password'
    resources :providers, controller: 'users/providers'
  end
  
  match 'users/providers/:provider_type/authorize' => 'users/providers#authorize'
  resources :checkins
  resources :venues
  resources :providers
  resources :callbacks do
    collection do
      get 'google'
      get 'facebook'
    end
  end
  resources :pages
end
