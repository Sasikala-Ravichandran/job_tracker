Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }, :path => 'accounts'
  
  resources :users do
    resources :documents
  end
  
  root 'welcome#index'

end
