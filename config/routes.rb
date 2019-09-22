Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :slideshows, only: :show do
    resources :slides, only: :show
  end

  namespace :admin do
    resources :slideshows
    resources :slides
  end
  root to: "home#index"
end
