# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieService do
  # here is where we should do a before all block as we build out more tests
  it 'can create a connection, and consume the api', :vcr do
    movie = MovieService.get_movie(324_857)

    expect(movie).to be_a(Hash)
    expect(movie[:original_title]).to be_a(String)
    expect(movie[:original_title]).to eq('Spider-Man: Into the Spider-Verse')
  end

  it 'can get top rated movies', :vcr do
    top_rated = MovieService.top_rated_movies

    expect(top_rated).to be_a(Hash)
    expect(top_rated[:results]).to be_an(Array)
    expect(top_rated[:results].first[:title]).to be_a(String)
    expect(top_rated[:results].first[:title]).to eq('The Godfather')
  end

  it 'can search specific movie', :vcr do
    search = MovieService.search_movie('Spider-Man: Into the Spider-Verse')

    expect(search).to be_a(Hash)
    expect(search[:results]).to be_an(Array)
    expect(search[:results][0][:original_title]).to be_a(String)
    expect(search[:results][0][:original_title]).to eq('Spider-Man: Into the Spider-Verse')
  end

  it 'can get cast and characters', :vcr do
    credits = MovieService.get_cast(324_857)

    expect(credits).to be_a(Hash)
    expect(credits[:cast]).to be_an(Array)
    expect(credits[:cast][0][:name]).to be_a(String)
    expect(credits[:cast][0][:name]).to eq('Shameik Moore')
    expect(credits[:cast][0][:character]).to be_a(String)
    expect(credits[:cast][0][:character]).to eq('Miles Morales / Spider-Man (voice)')
  end

  it 'can get reviews and author of review', :vcr do
    critique = MovieService.get_reviews(324_857)
    expected = "The visuals, concepts, soundtrack, and characters are some of the best I've ever seen!"

    expect(critique).to be_a(Hash)
    expect(critique[:results]).to be_an(Array)
    expect(critique[:results][19][:author]).to be_a(String)
    expect(critique[:results][19][:author]).to eq('StephenScott')
    expect(critique[:results][19][:content]).to be_a(String)
    expect(critique[:results][19][:content]).to eq(expected)
  end
end
