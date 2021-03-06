Rails.application.routes.draw do
  get 'welcome/index'

  # This is for accessing software's versions
  resources :softwares do
    resources :versions, only: [:show, :index, :new, :create]
  end
  # This is for accessing version alone
  resources :versions, only: [:show, :destroy, :edit, :update]

  resources :editors

  resources :operating_systems

  resources :pcs

  resources :rooms

  resources :tags

  resources :people

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
