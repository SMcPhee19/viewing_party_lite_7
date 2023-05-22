# frozen_string_literal: true

class MovieFacade
  def self.top_rated
    MovieService.top_rated_movies[:results].map do |movie|
      MovieDetail.new(movie)
    end
  end

  def self.get_movie(id)
    movie_info = MovieService.get_movie(id)
    movie_detail = MovieDetail.new(movie_info)
  end

  def self.keyword(movie_query)
    MovieService.search_movie(movie_query)[:results].map do |movie|
      MovieDetail.new(movie)
    end
  end

  def self.top_cast(id)
    cast_char = []
    MovieService.get_cast(id)[:cast][0..9].map do |cast_info|
      cast_char << "#{cast_info[:name]} as #{cast_info[:character]}"
    end
    cast_char
  end

  def self.reviews(id)
    review_data = []
    MovieService.get_reviews(id)[:results].map do |review|
      review_data << "#{review[:author]}'s review: #{review[:content]}"
    end
    review_data
  end
end
