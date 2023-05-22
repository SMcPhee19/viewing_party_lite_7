# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      redirect_to user_path(@new_user.id)
    else
      flash.notice = 'Oops, please try again. Make sure all fields are completed, email is unique, and your passwords match!'
      redirect_to '/register'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
