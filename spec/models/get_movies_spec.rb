require 'rails_helper'

RSpec.describe GetMovies, type: :model do
  it "GETs the movies from Film World endpoints as JSON and handles errors" do
    10.times do
      filmworld_response = GetMovies.get_movies("filmworld")
      expect(!!filmworld_response[:message]).to eq(false)
      expect(filmworld_response[:Provider]).to eq("Film World")
      expect(!!filmworld_response[:Movies]).to eq(true)
      expect(filmworld_response[:Movies].size).to be > 0
    end  
  end

  it "GETs the movies from Cinema World endpoints as JSON and handles errors" do
     
    10.times do
      cinemaworld_response = GetMovies.get_movies("cinemaworld")
      expect(!!cinemaworld_response[:message]).to eq(false)
      expect(cinemaworld_response[:Provider]).to eq("Cinema World")
      expect(!!cinemaworld_response[:Movies]).to eq(true)
      expect(cinemaworld_response[:Movies].size).to be > 0
    end
  end
end