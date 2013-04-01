SightSeeServer::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :editors, ActiveAdmin::Devise.config
  
  scope "/api/v1" do
    resources :locations, :reviews
  end
  
  root :to => redirect("/edit")

end
