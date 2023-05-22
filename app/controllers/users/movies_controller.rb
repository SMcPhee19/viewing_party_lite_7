# frozen_string_literal: true

module Users
  class MoviesController < ApplicationController
    def index
      @user = User.find(params[:user_id])
      @top_rated = if params['search'].present?
                     MovieFacade.keyword(params['search'])
                   else
                     MovieFacade.top_rated
                   end
    end

    def show
      # require 'pry'; binding.pry
      @user = User.find(params[:user_id])
      @movie = MovieFacade.get_movie(params[:id])
      @cast =  MovieFacade.top_cast(params[:id])
      @reviews = MovieFacade.reviews(params[:id])
      # require 'pry'; binding.pry
    end
  end
end
