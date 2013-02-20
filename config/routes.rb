SightSeeServer::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :editors, ActiveAdmin::Devise.config

  resources :locations do
    member do
      get 'locations'
    end
  end
  
  resources :reviews do
    member do
      post 'reviews'
    end
  end
  
  root :to => redirect("/edit")

end
