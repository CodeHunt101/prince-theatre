require 'rails_helper'

RSpec.describe Movie, type: :model do
  it "Converts numbers (integers and floats) to currency" do
    expect(Movie.number_to_currency(1000)).to eq("$1,000.00") 
    expect(Movie.number_to_currency(0)).to eq("$0.00")
    expect(Movie.number_to_currency(20.10)).to eq("$20.10") 
    expect(Movie.number_to_currency(1000000)).to eq("$1,000,000.00")
  end

  it "Returns the Movie Cards that displays all the movies information plus the prices of both streaming providers in number and currency formats" do
    movie_cards = Movie.movie_cards
    expect(movie_cards.class).to eq(Array)
    expect(movie_cards.size).to eq(11)
    expect(movie_cards.first.keys).to eq([:id, :title, :poster, :actors, :price])
    expect(movie_cards.first[:price].keys).to eq([:filmworld, :cinemaworld])
    expect(movie_cards.first[:id]).to eq("fw2488496")
    expect(movie_cards.last[:id]).to eq("fw0121766")
    expect(movie_cards.first[:price][:filmworld][:number]).to eq(25)
    expect(movie_cards.first[:price][:cinemaworld][:number]).to eq(24.7)
  end
end