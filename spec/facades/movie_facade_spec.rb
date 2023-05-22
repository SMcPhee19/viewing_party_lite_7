# frozen_string_literal: true

require 'rails_helper'
require './app/facades/movie_facade'

RSpec.describe MovieFacade do
  describe 'movie facade' do
    it 'creates movie poros', :vcr do
      movie = MovieFacade.get_movie(238)

      expect(movie).to be_a(MovieDetail)
      expect(movie.title).to eq('The Godfather')
      expect(movie.vote_average).to eq(8.711)
      expect(movie.overview).to eq('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.')
    end

    it 'creates top rated movies poros', :vcr do
      top_movie = MovieFacade.top_rated
      expect(top_movie.first).to be_a(MovieDetail)
    end

    it 'can call top_cast', :vcr do
      actors = MovieFacade.top_cast(238)
      expect(actors).to be_an(Array)
    end

    it 'can call reviews and authors of reviews', :vcr do
      critique = MovieFacade.reviews(238)
      expect(critique).to be_an(Array)
    end
  end
end
