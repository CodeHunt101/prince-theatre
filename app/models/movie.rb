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
        message: "There is a problem with retriving the information from the endpoints",
      }
    end
  end

  def self.cinemas_movie_prices_with_cheapest_movies
    # Defines all prices and which cinema has the cheapest movie

    begin
      max_cinema_movie_index = GetMovies.get_movies("filmworld")[:Movies].size - 1
      current_cinema_movie_index = 0
      cinemas_movie_prices = self.cinemas_movie_prices_without_filtering_cheapest_movies

      # Loop over all cinema movie indexes
      while current_cinema_movie_index <= max_cinema_movie_index
        # From each cinema movie index, find the cheapest price
        cheapest_movies = self.find_cheapest_movies_from_given_index(cinemas_movie_prices, current_cinema_movie_index)

        # For each cinema's movie price, find the one that has the same movie id as any movie from
        # the cheapest_movies array and set it equal to the found movie.
        cinemas_movie_prices.each do |cinema, price_info|
          cinema_price_info = cinemas_movie_prices[cinema][current_cinema_movie_index]

          found_cheapest_movie = cheapest_movies.find do |cinema|
            cinema[:movie_id] == cinema_price_info[:movie_id]
          end

          if found_cheapest_movie
            cinema_price_info = found_cheapest_movie
            break
          end
        end
        current_cinema_movie_index += 1
      end
      cinemas_movie_prices

      # Handles the most common exception type
    rescue NoMethodError => error
      {
        error: error,
        message: "There is a problem with retriving the information from the endpoints",
      }
    end
  end

  private

  def self.number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number)
  end

  def self.cinemas_movie_prices_without_filtering_cheapest_movies
    # For each endpoint, it adds all the prices as both currency and number formats.
    result = {}
    self.endpoints.each do |endpoint|
      result[endpoint] = GetMovies.get_movies(endpoint)[:Movies].map do |movie|
        {
          movie_id: movie[:ID],
          currency: self.number_to_currency(movie[:Price]),
          number: movie[:Price],
          cheapest: false,
        }
      end
    end
    result
  end

  def self.find_cheapest_movies_from_given_index(cinemas_movie_prices, cinema_movie_index)
    cheapest_movies = []
    # For each cinema price info from a given index, store only the cheapest one in the cheapest_movies array
    # If there is a another cinema with the same price for the same movie, push it to the array
    cinemas_movie_prices.each do |cinema, price_info|
      movie_price_info = cinemas_movie_prices[cinema][cinema_movie_index]
      if cheapest_movies.size == 0
        cheapest_movies << movie_price_info
      else
        if movie_price_info[:number] < cheapest_movies.last[:number]
          cheapest_movies = [movie_price_info]
        else
          if movie_price_info[:number] == cheapest_movies.last[:number]
            cheapest_movies << movie_price_info
          end
        end
      end
    end

    # Set the cheapest attribute to true for all the cheapst movies
    cheapest_movies.each { |movie| movie[:cheapest] = true }
  end

  def self.price_of_movie_by_cinema(cinema, index)
    GetMovies.get_movies(cinema)[:Movies][index][:Price]
  end
end
