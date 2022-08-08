Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :us, controllers: {
    omniauth_callbacks: 'us/omniauth_callbacks',
    #sessions: 'us/sessions',
    #registrations: 'us/registrations'
  }
	root "articles#index"

  resources :articles do
    resources :comments
  end

	#get '/signup' => 'users#new'
  #post '/users' => 'users#create'

  #get '/signin' => 'sessions#new'
 # post '/signin' => 'sessions#create'
  #get '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
