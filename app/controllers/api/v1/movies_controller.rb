class Api::V1::MoviesController < ApplicationController
  def render_movie_cards
    movie_cards = Movie.movie_cards
    render json: {
      response: movie_cards,
    }
  end

  def render_movie_prices
    movie_prices_by_cinema = Movie.cinemas_movie_prices_with_cheapest_movies
    render json: {
      response: movie_prices_by_cinema,
    }
  end
end
