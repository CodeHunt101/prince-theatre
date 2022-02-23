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

  def self.price_of_movie_by_cinema(cinema, index)
    GetMovies.get_movies(cinema)[:Movies][index][:Price]
  end

  def self.prices_of_cinemas_v_2
    # For each endpoint, it adds all the prices as both currency and number formats.
    
    # result = [
    #   {
    #     provider_1: {
    #       currency: $1, 
    #       number:1
    #     },
    #     provider_2: {
    #       currency: $2, 
    #       number:2
    #     },
    #   },
    #   {
    #     provider_1: {
    #       currency: $3, 
    #       number:3
    #     },
    #     provider_2: {
    #       currency: $1, 
    #       number:1
    #     },
    #   },
    # ]
    result = []
    
      
      
      GetMovies.get_movies("filmworld")[:Movies].each_with_index do |movie,index|
        prices = {}
        self.endpoints.each do |endpoint|
          prices[endpoint] = {
            currency: self.number_to_currency(price_of_movie_by_cinema(endpoint, index)),
            number: price_of_movie_by_cinema(endpoint, index)
          }
        end
      result << prices
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

  def self.prices_of_cinemas_v_2
    # For each endpoint, it adds all the prices as both currency and number formats.
    
    # result = [
    #   {
    #     provider_1: {
    #       currency: $1, 
    #       number:1
    #     },
    #     provider_2: {
    #       currency: $2, 
    #       number:2
    #     },
    #   },
    #   {
    #     provider_1: {
    #       currency: $3, 
    #       number:3
    #     },
    #     provider_2: {
    #       currency: $1, 
    #       number:1
    #     },
    #   },
    # ]
    result = []
    
      prices = {}
      self.endpoints.each do |endpoint|
        GetMovies.get_movies("filmworld")[:Movies].each do |movie|
        prices[endpoint] = {
          currency: self.number_to_currency(movie[:Price]),
          number: movie[:Price]
        }
      end
      result << prices
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