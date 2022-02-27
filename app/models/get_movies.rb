class GetMovies < ApplicationRecord
  
  def self.get_movies(theatre_name)
    # Fetches the movies information. It'll retry for up to 10 times if the retrieved information is unsuccessful.
    response = self.fetch_movies(theatre_name)
    
    attempts = 10
    while (response[:message] == "Bad Gateway" || response[:message] == "Server Error")
      break if attempts == 0
      response = self.fetch_movies(theatre_name)
      attempts -= 1
    end
    
    response
  end

  private

  def self.fetch_movies(theatre_name)
    # Fetches the movies by using the HTTParty Ruby library and parses it to JSON
    response = HTTParty.get("https://challenge.lexicondigital.com.au/api/v2/#{theatre_name}/movies",
      headers: {
        "content-type": "application/json",
        "x-api-key": ENV['API_KEY']
      }, format: :plain)

    JSON.parse response, symbolize_names: true
  end
end