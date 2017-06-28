Rails.application.routes.draw do
  get 'welcome/index'
  match '/get-version-details' => 'versions#get_details', via: [:get, :post]

  # Resources
  resources :softwares do
    resources :versions #, shallow: true
  end
  resources :editors
  resources :operating_systems
  resources :pcs
  resources :rooms
  resources :tags
  resources :people

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
