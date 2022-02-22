class Api::V1::MoviesController < ApplicationController
  def render_movie_cards
    movie_cards = Movie.movie_cards
    render json: {
      response: movie_cards
    }
  end
end