# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  before(:each) do
    @user1 = User.create!(name: 'Bob', email: 'bob@email.com', password: 'password', password_confirmation: 'password')
    @user2 = User.create!(name: 'Sally', email: 'sally@email.com', password: 'password',
                          password_confirmation: 'password')
    @user3 = User.create!(name: 'Joe', email: 'joe@email.com', password: 'password', password_confirmation: 'password')
    visit root_path
  end

  it 'when on the landing page, I see the title of the application' do
    expect(page).to have_content('Viewing Party')
  end

  it 'when on the landing page, I see a button to create a new user' do
    within '#new-user' do
      expect(page).to have_button('New User')
    end
  end

  it 'when in the landing page, I see a list of all existing users' do
    within '#existing-users' do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user3.name)
    end
  end

  it 'when in the landing page, when I click on a user, I am taken to thier personal dashboard' do
    within '#existing-users' do
      click_link(@user1.name)
      expect(current_path).to eq("/users/#{@user1.id}")
      expect(current_path).to_not eq("/users/#{@user2.id}")
      expect(current_path).to_not eq("/users/#{@user3.id}")

      visit root_path
      click_link(@user2.name)
      expect(current_path).to eq("/users/#{@user2.id}")
      expect(current_path).to_not eq("/users/#{@user1.id}")
      expect(current_path).to_not eq("/users/#{@user3.id}")

      visit root_path
      click_link(@user3.name)
      expect(current_path).to eq("/users/#{@user3.id}")
      expect(current_path).to_not eq("/users/#{@user1.id}")
      expect(current_path).to_not eq("/users/#{@user2.id}")
    end
  end

  it 'when in the landing page, I see a link back to the landing page' do
    expect(page).to have_link('Home')

    click_link('Home')
    expect(current_path).to eq(root_path)
  end
end
