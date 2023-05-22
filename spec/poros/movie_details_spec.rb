require 'rails_helper'

RSpec.describe 'movie_detail poros' do
  describe 'it exists' do
    it 'has attributes' do
      movie = MovieDetail.new(title: 'Blah', id: 40, overview: 'sucks', runtime: 140, vote_average: 6.9,
                              poster_path: nil)

      expect(movie.title).to be_a(String)
      expect(movie.id).to be_an(Integer)
      expect(movie.overview).to be_a(String)
      expect(movie.runtime).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
    end

    it 'has method for formatting time' do
      movie = MovieDetail.new(title: 'Blah', id: 40, overview: 'sucks', genre: 'romantic', runtime: 140,
                              vote_average: 6.9, poster_path: nil)

      expect(movie.format_runtime(140)).to eq('2h 20min')
    end
  end
end
