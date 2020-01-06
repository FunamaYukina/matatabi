Rails.application.routes.draw do

  root "home#top"
  get "top" => "home#index"

  devise_for :users, :controllers => {
      :registrations => 'devise/registrations'
  }
end
