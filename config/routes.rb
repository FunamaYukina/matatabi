Rails.application.routes.draw do

  root "home#top"
  get "top" => "home#index"

end
