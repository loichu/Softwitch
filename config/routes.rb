Rails.application.routes.draw do
  get 'welcome/index'

  # Resources
  resources :softwares
  resources :editors
  resources :operating_systems
  resources :pcs
  resources :rooms
  resources :tags
  resources :versions
  resources :people

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
