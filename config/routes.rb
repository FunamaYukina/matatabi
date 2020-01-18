Rails.application.routes.draw do

  root "home#top"
  get "top" => "home#index"

  devise_for :users, :controllers => {
      :registrations => 'users/registrations'
  }

  resources :users, param: :name do
    resources :plans, except: [:show, :index]
    get :search, on: :collection
    resource :profile, only: [:show, :edit, :update]
  end

  resources :rooms
  resources :talks
end
