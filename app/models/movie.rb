class Movie < ApplicationRecord
  # ActionController::Base.helpers.number_to_currency
  
  def self.endpoints
    ["filmworld", "cinemaworld"]
  end

  def self.prices_of_cinemas
    # For each endpoint, it adds all the prices as both currency and number formats.
    result = {}
    self.endpoints.each do |endpoint|
      result[endpoint] = GetMovies.get_movies(endpoint)[:Movies].map do |movie|
        {
          cinema_id: movie[:ID],
          currency: self.number_to_currency(movie[:Price]),
          number: movie[:Price]
        }
      end
    end
    result
  end
  
  def self.movie_cards
    # Assumption:
    # Since streaming providers share the same information (except prices) and also the information of each one has the same order, 
    # the prices of each streaming provider's movie share the same indexes.
    
    begin
      movie_cards = []
      # Loop over one of the streaming providers and only retrieve the information that is shared among all endpoints.
      GetMovies.get_movies("filmworld")[:Movies].each do |movie|
        movie_info = {
          id: movie[:ID],
          title: movie[:Title],
          poster: movie[:Poster],
          actors: movie[:Actors],
        }
        movie_cards << movie_info
      end
      movie_cards


    rescue NoMethodError => error
      {
        error: error, 
        message: "There is a problem with retriving the information from the endpoints"
      }
    end
  end


  private
  
  def self.number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number)
  end

end