# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe 'when I visit the users/:id/discover page' do
    before(:each) do
      @user1 = User.create(name: 'Bob', email: 'bob@email.com', password: 'password', password_confirmation: 'password')
      @user2 = User.create(name: 'Sally', email: 'sally@email.com', password: 'password', password_confirmation: 'password')
    end

    it 'I see a button to discover top rated movies', :vcr do
      visit user_discover_index_path(@user1)

      expect(page).to have_content('Discover Movies Page')
      within '#top-rated' do
        expect(page).to have_button('Discover Top Rated Movies')

        click_button('Discover Top Rated Movies')
      end
      expect(current_path).to eq(user_movie_index_path(@user1))
      expect(page).to have_content('Movies Results Page')
    end

    it 'I see a search field to search for movies and can click the search button and see new movie', :vcr do
      visit user_discover_index_path(@user1)

      within '#search-movie' do
        fill_in 'Enter Movie Title', with: 'Your Name.'
        click_button 'Search'
      end
      expect(current_path).to eq(user_movie_index_path(@user1))

      within '#movie-1' do
        expect(page).to have_link('Your Name.')
        expect(page).to have_content(8.5)
      end
    end
  end
end
