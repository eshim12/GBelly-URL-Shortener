Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			post 'login', to: 'auth#create'

			resources :users, only: [:create]

		 	resources :urls, only: [:index, :create, :update, :destroy]
		end
	end
	get ':slug', to: 'api/v1/urls#show'
end
