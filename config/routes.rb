Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :slideshows, only: :show

  namespace :admin do
    resources :slideshows
    resources :slides
  end
  root to: "home#index"
end
