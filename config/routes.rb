Rails.application.routes.draw do
	require 'sidekiq/web'

	mount Sidekiq::Web, at: '/sidekiq'
	
  begin
    ActiveAdmin.routes(self)
  rescue Exception => e
    puts "ActiveAdmin: #{e.class}: #{e}"
  end

  devise_for :users

  devise_scope :user do
    root to: 'users/admin_sessions#new'
    get "/admin/sign_in", to: "users/admin_sessions#new", as: :admin_session
    post "/admin/sign_in", to: "users/admin_sessions#create", as: :admin_create_session
  end

  # devise_for :users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	namespace :api , defaults: { format: 'json' } do
    namespace :v1 do
      devise_scope :user do
        post 'sign_in', to: 'sessions#create'
        post 'sign_up', to: 'registrations#create'
      end
    	resources :auctions, only: [:index, :show] do
  		  resources :auction_items, only: [:index, :show] do
		  		resource :auction_item_bids do
		        collection do
		          get :highest_bids
		          get :bid_lists
		        end
		      end
  		  end
  		end
    end
  end
end
