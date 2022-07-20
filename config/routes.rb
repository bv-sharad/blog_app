Rails.application.routes.draw do
	devise_for :us, controllers: {
		omniauth_callbacks: 'us/omniauth_callbacks',
	}
	root "articles#index"

	resources :articles do
		resources :comments
	end
end
