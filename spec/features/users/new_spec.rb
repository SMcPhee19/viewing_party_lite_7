require 'rails_helper'

RSpec.describe 'Registration Page' do
  describe 'as a user when I visit the registration page I see a form to register' do
    it 'displays registration form' do
      visit '/register'

      within '#registration-form' do 
        expect(page).to have_field('name')
        expect(page).to have_field('email')
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_button('Save')
      end
    end
    
    it 'can fill in form and submit' do
      visit '/register'
      
      within '#registration-form' do
        fill_in 'name', with: 'Barnaby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'
        
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
      
      #save_and_open_page
      expect(current_path).to eq('/register')
      expect(page).to have_content("Oops, please try again. Make sure all fields are completed and email is unique!")
    end

    it 'displays error message and redirects if email is not unique' do
      @user1 = User.create!(name: 'Geraldine Peters', email: 'freshtodeath@aol.com')
      visit '/register'
      
      within '#registration-form' do
        fill_in 'name', with: 'Baranby Jones'
        fill_in 'email', with: 'freshtodeath@aol.com'
        
        click_button 'Save'
      end
      
      #save_and_open_page
      expect(current_path).to eq('/register')
      expect(page).to have_content("Oops, please try again. Make sure all fields are completed and email is unique!")
    end
  end
end