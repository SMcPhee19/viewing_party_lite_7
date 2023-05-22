# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration Page' do
  describe 'as a user when I visit the registration page I see a form to register' do
    it 'displays registration form' do
      visit '/register'

      within '#registration-form' do
        expect(page).to have_field('name')
        expect(page).to have_field('email')
        expect(page).to have_field('password')
        expect(page).to have_field('confirm_password')
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Confirm Password')
        expect(page).to have_button('Save')
      end
    end

    it 'can fill in form and submit' do
      visit '/register'

      within '#registration-form' do
        fill_in 'name', with: 'Barnaby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'
        fill_in 'password', with: 'YouHadMeAtPassword'
        fill_in 'confirm_password', with: 'YouHadMeAtPassword'
        click_button 'Save'
      end

      expect(current_path).to eq(user_path(User.last.id))
    end
  end

  describe 'registration error message' do
    it 'displays error message and redirects to registration form if missing fields' do
      visit '/register'

      within '#registration-form' do
        fill_in 'name', with: ''
        fill_in 'email', with: 'freshtodeath@aol.com'

        click_button 'Save'
      end

      expect(current_path).to eq('/register')
      expect(page).to have_content('Oops, please try again. Make sure all fields are completed, email is unique, and your passwords match!')
    end

    it 'displays error message and redirects if email is not unique' do
      @user1 = User.create!(name: 'Geraldine Peters', email: 'freshtodeath@aol.com', password: 'password', password_confirmation: 'password')
      visit '/register'

      within '#registration-form' do
        fill_in 'name', with: 'Baranby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'

        click_button 'Save'
      end

      expect(current_path).to eq('/register')
      expect(page).to have_content('Oops, please try again. Make sure all fields are completed, email is unique, and your passwords match!')
    end
  end

  describe 'authentication challenge' do
    it 'happy path' do
      visit '/register'

      within '#registration-form' do
        fill_in 'name', with: 'Barnaby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'
        fill_in 'password', with: 'YouHadMeAtPassword'
        fill_in 'confirm_password', with: 'YouHadMeAtPassword'
        click_button 'Save'
      end
    end

    it 'sad path: passwords do not match' do
      visit '/register'

      within '#registration-form' do
        fill_in 'name', with: 'Barnaby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'
        fill_in 'password', with: 'YouHadMeAtPassword'
        fill_in 'confirm_password', with: '100%Chillin'
        click_button 'Save'
      end

      expect(current_path).to eq('/register')
      expect(page).to have_content('Oops, please try again. Make sure all fields are completed, email is unique, and your passwords match!')
    end
  end
end
