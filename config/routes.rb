Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/filmworld", to: "movies#render_filmworld_movies"
      get "/cinemaworld", to: "movies#render_cinemaworld_movies"
    end
  end
end
