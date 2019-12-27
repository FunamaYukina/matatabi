Rails.application.routes.draw do

  root "home#top"
  get "top" => "home#index"

  devise_for :users, :controllers => {
      :registrations => 'users/registrations'
  }

  resources :users, param: :name do
    resources :plans,except: [:show, :index]
    resource :profile, only: [:show, :edit, :update]
  end
end
