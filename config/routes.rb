Rails.application.routes.draw do

	root 'blogs#index'

	devise_for :users, controllers: {registrations: "users/registrations"}
	
	resources :blogs do
		member do
			resources :comments do
				post :add_reply
				get :view_replies
			end
			post :upvote
		end

		collection do
			get :my_blogs
		end
	end
end