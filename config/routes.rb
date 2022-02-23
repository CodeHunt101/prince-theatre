Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/movie_cards", to: "movies#render_movie_cards"
      get "/movie_prices", to: "movies#render_movie_prices"
    end
  end
end
