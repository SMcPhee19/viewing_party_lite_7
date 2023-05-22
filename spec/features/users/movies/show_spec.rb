require 'rails_helper'

RSpec.describe 'user story 10' do
  describe 'movie details page' do
    before(:each) do
      @user1 = User.create(name: 'Bob', email: 'bob@email.com', password: 'password', password_confirmation: 'password')
      @user2 = User.create(name: 'Sally', email: 'sally@email.com', password: 'password',
                           password_confirmation: 'password')
    end

    it 'displays a button to create a viewing party', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#create-party' do
        expect(page).to have_button('Create Viewing Party for Movie')
        click_button 'Create Viewing Party for Movie'
      end
      expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, 324_857))
    end

    it 'displays a button to return to the discover page', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#discover-button' do
        expect(page).to have_button('Back to Discover')
        click_button 'Back to Discover'
      end

      expect(current_path).to eq(user_discover_index_path(@user1))
    end

    it 'displays movie title and vote average', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-details' do
        expect(page).to have_content('Spider-Man: Into the Spider-Verse')
        expect(page).to have_content(8.4)
      end
    end

    it 'displays movie runtime in hours and minutes', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-details' do
        expect(page).to have_content('1h 57min')
      end
    end

    it 'displays movie genre', :vcr do
      visit "/users/#{@user1.id}/movie/324857"
      within '#movie-details' do
        expect(page).to have_content('Action')
        expect(page).to have_content('Adventure')
        expect(page).to have_content('Animation')
        expect(page).to have_content('Science Fiction')
      end
    end

    it 'displays summary of movie', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-details' do
        expect(page).to have_content('Miles Morales is juggling his life between being a high school student and being a spider-man. When Wilson "Kingpin" Fisk uses a super collider, others from across the Spider-Verse are transported to this dimension.')
      end
    end

    it 'displays first 10 cast members', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-details' do
        expect(page).to have_content('Shameik Moore')
        expect(page).to have_content('Brian Tyree Henry')
        expect(page).to have_content('Kimiko Glenn')
      end
    end

    it 'displays count of total reviews', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-reviews' do
        expect(page).to have_content(20)
      end
    end

    it 'displays each reviews author and information', :vcr do
      visit "/users/#{@user1.id}/movie/324857"

      within '#movie-reviews' do
        expect(page).to have_content('StephenScott')
        expect(page).to have_content("The visuals, concepts, soundtrack, and characters are some of the best I've ever seen!")
        expect(page).to have_content('JacobKing1')
        expect(page).to have_content('Sony really nails making character movement look detailed and pronounced.')
      end
    end
  end
end
