class Movie < ApplicationRecord
  # ActionController::Base.helpers.number_to_currency
  
  def self.movie_cards
    # include ActionView::Helpers::NumberHelper
    # Since both streaming providers share the same information (except prices) and also the information of each one has the same order, 
    # the prices of each streaming provider's movie share the same indexes.

    # I mapped one of the streaming providers where I slightly modified the price keys by using a hash with the price of 
    # the movie of that provider.
    
    movies_info_without_cinemaworld_prices = GetMovies.get_movies("filmworld")[:Movies].map do |movie|
      {
        id: movie[:ID],
        title: movie[:Title],
        poster: movie[:Poster],
        actors: movie[:Actors],
        price: {
          filmworld: {
            currency: self.number_to_currency(movie[:Price]),
            number: movie[:Price]
          }
        }
      }
    end

    # Then I mapped the other streaming provider by only returning an array of prices and
    # assigning them to a new key that will be the prices of the other streaming provider

    cinemaworld_prices = GetMovies.get_movies("cinemaworld")[:Movies].map do |movie|
        {
          currency: self.number_to_currency(movie[:Price]),
          number: movie[:Price]
        }
    end

    movie_cards = movies_info_without_cinemaworld_prices.each_with_index do |movie, index|
      movie[:price][:cinemaworld] = cinemaworld_prices[index]
    end
  end

  private
  
  def self.number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number)
  end

end