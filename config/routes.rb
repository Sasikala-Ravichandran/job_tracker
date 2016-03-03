Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }, :path => 'accounts'
  
  resources :users do
    resources :documents
    resources :positions
  end
  
  root 'welcome#index'

end
