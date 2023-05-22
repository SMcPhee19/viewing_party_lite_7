# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard' do
  before(:each) do
    @user1 = User.create(name: 'Bob', email: 'bob@email.com', password: 'password', password_confirmation: 'password')
    @user2 = User.create(name: 'Sally', email: 'sally@email.com', password: 'password', password_confirmation: 'password')
    visit user_path(@user1)
  end

  describe 'User Story 5' do
    it 'when I visit the user dashboard, I see a header with that users name' do
      expect(page).to have_link('Home')
      expect(page).to have_content('Viewing Party')
      expect(page).to have_content("#{@user1.name}'s Dashboard")
      expect(page).to_not have_content(@user2.name)
    end

    it 'when I visit the user dashboard, I see a button to discover movies' do
      within '#discover-movies' do
        expect(page).to have_button('Discover Movies')
        expect(page).to_not have_content('My Viewing Parties')
      end
    end

    it 'when I visit the user dashboard, and click the discover movies button,
    I am take to that users discover movies page' do
      within '#discover-movies' do
        click_button('Discover Movies')
      end

      expect(current_path).to eq("/users/#{@user1.id}/discover")
      expect(current_path).to_not eq("/users/#{@user2.id}/discover")

      expect(page).to have_link('Home')
      expect(page).to have_content('Viewing Party')
      expect(page).to have_content('Discover Movies')
    end

    it 'when I visit the user dashboard, I see a section listing viewing parties' do
      within '#viewing-parties' do
        expect(page).to have_content('My Viewing Parties')
        expect(page).to_not have_content('Discover Movies')
      end
    end
  end
end
