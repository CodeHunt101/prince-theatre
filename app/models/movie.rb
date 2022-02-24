class Movie < ApplicationRecord
  
  def self.endpoints
    ["filmworld", "cinemaworld"]
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
          id: movie[:ID][2..-1],
          title: movie[:Title],
          poster: movie[:Poster],
          actors: movie[:Actors],
        }
        movie_cards << movie_info
      end
      movie_cards

    # Handles the most common exception type
    rescue NoMethodError => error
      {
        error: error, 
        message: "There is a problem with retriving the information from the endpoints"
      }
    end
  end
  
  def self.prices_of_cinemas_with_cheapest_movies
    # Defines all prices and which cinema has the cheapest movie
    
    begin
      max_movie_index = GetMovies.get_movies("filmworld")[:Movies].size-1
      movie_index = 0
      prices_of_cinemas = self.prices_of_cinemas_without_filtering_the_cheapests
      
      # Loop over all movie indexes
      while movie_index <= max_movie_index
        temp = nil
        
        # For each cinema price info, store only the cheapest one in a temp variable
        # and set the "cheapest" attribute to true
        prices_of_cinemas.each do |cinema, price_info|
          movie_price_info = prices_of_cinemas[cinema][movie_index]
          
          if !temp       
            temp = movie_price_info
          else
            if temp[:number] > movie_price_info[:number]
              temp = movie_price_info
            end
            temp[:cheapest] = true
          end

        end
        
        # For each cinema price, find the one that has the same movie id as the temp 
        # variable and set it equal to the temp variable.
        prices_of_cinemas.each do |cinema,price_info|
          movie_price_info = prices_of_cinemas[cinema][movie_index]
          
          if movie_price_info[:movie_id] == temp[:movie_id]
            movie_price_info = temp
            break
          end

        end
        
        movie_index +=1

      end
      prices_of_cinemas
    
    # Handles the most common exception type
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

  def self.prices_of_cinemas_without_filtering_the_cheapests
    # For each endpoint, it adds all the prices as both currency and number formats.
    result = {}
    self.endpoints.each do |endpoint|
      result[endpoint] = GetMovies.get_movies(endpoint)[:Movies].map do |movie|
        {
          movie_id: movie[:ID],
          currency: self.number_to_currency(movie[:Price]),
          number: movie[:Price],
          cheapest: false
        }
      end
    end
    result
  end

  def self.price_of_movie_by_cinema(cinema, index)
    GetMovies.get_movies(cinema)[:Movies][index][:Price]
  end

end