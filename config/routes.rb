Rails.application.routes.draw do
  
  resources :tenants do
    resources :projects
  end
  resources :members
  get 'home/index'

   root :to => "home#index"

    
  # *MUST* come *BEFORE* devise's definitions (below)
  # als modified to go to our custom confirmations_controller rather than milia's
  as :user do   
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  # als again, confirmations goes our custom confirmations_controller and not milia's
  devise_for :users, :controllers => { 
    :registrations => "milia/registrations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions", 
    :passwords => "milia/passwords", 
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
