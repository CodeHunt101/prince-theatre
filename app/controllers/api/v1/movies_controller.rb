class Api::V1::MoviesController < ApplicationController
  def render_filmworld_movies
    movies = GetMovies.get_movies('filmworld')
    render json: {
      response: movies
    }
  end

  def render_cinemaworld_movies
    movies = GetMovies.get_movies('cinemaworld')
    render json: {
      response: movies
    }
  end
end