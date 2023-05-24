# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    unless current_user
      flash.notice = 'Please login or register to continue.'
      redirect_to root_path
    end
  end

  def new; end

  def create
    @new_user = User.new(user_params)
    if @new_user.save && params[:password] == params[:confirm_password]
      session[:user_id] = @new_user.id
      redirect_to user_path(@new_user.id)
    else
      flash.notice = 'Oops, please try again. Make sure all fields are completed, email is unique, and your passwords match!'
      redirect_to '/register'
    end
  end

  def login_form; end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash.notice = "Welcome, #{@user.name}!"
      redirect_to user_path(@user.id)
    else
      flash.notice = 'Sorry, your credentials are bad. Please try again.'
      render :login_form
    end
  end

  def logout
    session.delete(:user_id)
    flash.notice = 'You have been logged out.'
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
