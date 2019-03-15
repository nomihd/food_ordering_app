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

  get 'home/index'
  # get 'home/owner_dashboard'
  # get 'home/customer_dashboard'

  namespace :owners do
    resources :dashboard
  end

  namespace :customers do
    resources :dashboard
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
