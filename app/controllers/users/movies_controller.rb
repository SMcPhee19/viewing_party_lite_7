# frozen_string_literal: true

module Users
  class MoviesController < ApplicationController
    before_action :require_account
    
    def index
      @user = User.find(params[:user_id])
      @top_rated = if params['search'].present?
                     MovieFacade.keyword(params['search'])
                   else
                     MovieFacade.top_rated
                   end
    end

    def show
      @user = User.find(params[:user_id])
      @movie = MovieFacade.get_movie(params[:id])
      @cast =  MovieFacade.top_cast(params[:id])
      @reviews = MovieFacade.reviews(params[:id])
    end

    private
    def require_account
      unless current_user
        flash.notice = 'Please login or register to continue.'
        redirect_to root_path
      end
    end
  end
end
