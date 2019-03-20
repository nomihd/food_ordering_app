Rails.application.routes.draw do
  # devise_for :owners
  # devise_for :customers
  devise_for :owners, controllers: {
        registrations: 'owners/registrations',
        sessions: 'owners/sessions'
      }
  
  devise_for :customers, controllers: {
        registrations: 'customers/registrations',
        sessions: 'customers/sessions'
      }

  get 'home', to: 'home#index' 
  # get 'home/owner_dashboard'
  # get 'home/customer_dashboard'

  # get 'owners/restaurants/index', to: 'restaurants#show'#action: :show, controller: 'restaurants'
  namespace :owners do
    resources :dashboard, only: [:index]
    resources :restaurants, except: [:new, :create, :destroy]
    resources :categories
  end

  namespace :customers do
    resources :dashboard# do
    #   collection do
    #     match 'search', to: 'dashboard#search', via: [:get, :post]
    #   end
    # end
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
