Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: 'stores#index'
  match '/' => 'stores#create', via: :post
  match '/:id' => 'stores#getRequest', via: :get
  match '/' => 'stores#getRequest', via: :get

end
