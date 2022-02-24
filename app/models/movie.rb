class Movie < ApplicationRecord
  # ActionController::Base.helpers.number_to_currency
  
  def self.endpoints
    ["filmworld", "cinemaworld"]
  end

  def self.price_of_movie_by_cinema(cinema, index)
    GetMovies.get_movies(cinema)[:Movies][index][:Price]
  end

  def self.prices_of_cinemas
    # For each endpoint, it adds all the prices as both currency and number formats and finds the cheapest price.
    
    result = []
    max_movie_index = GetMovies.get_movies("filmworld")[:Movies].size - 1
    movie_index = 0
    
    # For each movie index, store the prices as number and currency formats for each endpoint (cinema)
    while movie_index<=max_movie_index
      prices = {}
      self.endpoints.each do |endpoint|
        movie_price = price_of_movie_by_cinema(endpoint, movie_index)
        prices[endpoint] = {
          currency: self.number_to_currency(movie_price),
          number: movie_price,
          cheapest: false
        }
      end
      # Find the minimum price and set the cheapest attr to true, and push the object to the results array
      prices.values.min_by{|price_obj| price_obj[:number]}[:cheapest] = true
      result << prices
      movie_index += 1
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