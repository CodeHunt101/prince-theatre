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
    prices_of_cinemas = Movie.prices_of_cinemas_without_filtering_the_cheapests
    expect(prices_of_cinemas.class).to eq(Hash)
    expect(prices_of_cinemas.size).to eq(endpoints.size)
    expect(prices_of_cinemas[prices_of_cinemas.keys.first].size).to eq(11)
    expect(prices_of_cinemas[prices_of_cinemas.keys.first].first.keys).to eq([:movie_id, :currency, :number, :cheapest])
    expect(prices_of_cinemas[prices_of_cinemas.keys.first].first[:currency][0]).to eq("$")
  end
  

  it "Returns the Movie Cards that displays all the movies information" do
    movie_cards = Movie.movie_cards
    expect(movie_cards.class).to eq(Array)
    expect(movie_cards.size).to eq(11)
    expect(movie_cards.first.keys).to eq([:id, :title, :poster, :actors])
    expect(movie_cards.first[:id]).to eq("2488496")
    expect(movie_cards.last[:id]).to eq("0121766")
  end

  it "Returns the prices of cinemas, including the cheapest prices per movie between two endpoints" do
    # This test will check several times that the condition 
    
    prices_of_cinemas = Movie.prices_of_cinemas_with_cheapest_movies
    5.times do  
      rand_index = rand(0..10)
      rand_endpoint_1 = endpoints[rand(0..endpoints.size-1)]
      rand_endpoint_2 = endpoints[rand(0..endpoints.size-1)]

      while rand_endpoint_1 == rand_endpoint_2
        rand_endpoint_1 = endpoints[rand(0..endpoints.size-1)]
        rand_endpoint_2 = endpoints[rand(0..endpoints.size-1)]
      end

      random_movie_price_from_random_endpoint_1 = prices_of_cinemas[rand_endpoint_1][rand_index][:number]
      random_movie_price_from_random_endpoint_2 = prices_of_cinemas[rand_endpoint_2][rand_index][:number]
      
      if random_movie_price_from_random_endpoint_1 < random_movie_price_from_random_endpoint_2
        expect(prices_of_cinemas[rand_endpoint_1][rand_index][:cheapest]).to eq(true)
        expect(prices_of_cinemas[rand_endpoint_2][rand_index][:cheapest]).to eq(false)
      else
        expect(prices_of_cinemas[rand_endpoint_1][rand_index][:cheapest]).to eq(false)
        expect(prices_of_cinemas[rand_endpoint_2][rand_index][:cheapest]).to eq(true)
      end
    end
  end

  # it "Returns the prices of cinemas, including the cheapest prices per movie" do
  #   # This test will check several times that the condition 
    
  #   prices_of_cinemas = Movie.prices_of_cinemas_with_cheapest_movies
  #   5.times do  
  #     rand_index = rand(0..10)
  #     rand_endpoint_1 = endpoints[rand(0..endpoints.size-1)]
  #     other_endpoints = endpoints.filter{|e| e != rand_endpoint_1}


  #     random_movie_price_from_random_endpoint_1 = prices_of_cinemas[rand_endpoint_1][rand_index][:number]
  #     # random_movie_price_from_other_endpoints = prices_of_cinemas[rand_endpoint_2][rand_index][:number]
      
  #     if random_movie_price_from_random_endpoint_1 < random_movie_price_from_random_endpoint_2
  #       expect(prices_of_cinemas[rand_endpoint_1][rand_index][:cheapest]).to eq(true)
  #       expect(prices_of_cinemas[rand_endpoint_2][rand_index][:cheapest]).to eq(false)
  #     else
  #       expect(prices_of_cinemas[rand_endpoint_1][rand_index][:cheapest]).to eq(false)
  #       expect(prices_of_cinemas[rand_endpoint_2][rand_index][:cheapest]).to eq(true)
  #     end
  #   end
  # end
  
end