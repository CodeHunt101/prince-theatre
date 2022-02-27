require 'rails_helper'

RSpec.describe Movie, type: :model do
  endpoints = Movie.endpoints
  
  it "Returns all the endpoints (cinema names)" do
    expect(endpoints.size).to be >= 2
    expect(endpoints.find{|e| e == "filmworld"})
    expect(endpoints.find{|e| e == "cinemaworld"})
  end
  
  it "Converts numbers (integers and floats) to currency" do
    expect(Movie.number_to_currency(1000)).to eq("$1,000.00") 
    expect(Movie.number_to_currency(0)).to eq("$0.00")
    expect(Movie.number_to_currency(20.10)).to eq("$20.10") 
    expect(Movie.number_to_currency(1000000)).to eq("$1,000,000.00")
  end

  it "Returns prices of cinemas as number and currency formats in a Hash, including the movie ID" do
    cinema_movie_prices = Movie.cinemas_movie_prices_without_filtering_cheapest_movies
    expect(cinema_movie_prices.class).to eq(Hash)
    expect(cinema_movie_prices.size).to eq(endpoints.size)
    expect(cinema_movie_prices[cinema_movie_prices.keys.first].size).to eq(11)
    expect(cinema_movie_prices[cinema_movie_prices.keys.first].first.keys).to eq([:movie_id, :currency, :number, :cheapest])
    expect(cinema_movie_prices[cinema_movie_prices.keys.first].first[:currency][0]).to eq("$")
  end
  

  it "Returns the Movie Cards that display all the movies information" do
    movie_cards = Movie.movie_cards
    expect(movie_cards.class).to eq(Array)
    expect(movie_cards.size).to eq(11)
    expect(movie_cards.first.keys).to eq([:id, :title, :poster, :actors])
    expect(movie_cards.first[:id]).to eq("2488496")
    expect(movie_cards.last[:id]).to eq("0121766")
  end

  it "Finds the cheapest movies from an index of given arrays of cinema movie prices" do  
    # First argument of the following method (mock_cinemas_movie_prices) is stored in spec/support
    cheapest_prices_at_idx_0 = Movie.find_cheapest_movies_from_given_index(mock_cinemas_movie_prices, 0)
    cheapest_prices_at_idx_1 = Movie.find_cheapest_movies_from_given_index(mock_cinemas_movie_prices, 1)
    cheapest_prices_at_idx_5 = Movie.find_cheapest_movies_from_given_index(mock_cinemas_movie_prices, 5)

    # All cinemas have the same price for the movie at index 0
    expect(cheapest_prices_at_idx_0[0]).to eq({
      :movie_id => "fw2488496",
      :currency => "$25.00",
        :number => 25,
      :cheapest => true
  })
    expect(cheapest_prices_at_idx_0[1]).to eq({
      :movie_id => "cw2488496",
      :currency => "$25.00",
        :number => 25,
      :cheapest => true
  })
    expect(cheapest_prices_at_idx_0[2]).to eq({
      :movie_id => "nw2488496",
      :currency => "$25.00",
        :number => 25,
      :cheapest => true
  })
    
    # Cinema 3 is the cheapest of all at index 1
    expect(cheapest_prices_at_idx_1[0]).to eq({
      :movie_id => "nw2527336",
      :currency => "$23.50",
        :number => 23.5,
      :cheapest => true
  })

    # Cinema 1 and Cinema 3 are the cheapests at index 5
    expect(cheapest_prices_at_idx_5[0]).to eq({
      :movie_id => "fw0076759",
      :currency => "$22.90",
        :number => 22.9,
      :cheapest => true
  })
    expect(cheapest_prices_at_idx_5[1]).to eq({
      :movie_id => "nw0076759",
      :currency => "$22.90",
        :number => 22.9,
      :cheapest => true
  })
  end

  it "Returns the prices of cinemas, including the cheapest prices per movie between two endpoints" do
    # Mock_movie_prices_expected_endpoint is stored in spec/support
    expect(Movie.cinemas_movie_prices_with_cheapest_movies).to eq(mock_movie_prices_expected_endpoint)
  end

end