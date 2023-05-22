require 'rails_helper'

RSpec.describe 'Logging in' do
  it 'Happy Path: can log in with valid credentials' do
    user = User.create!(name: 'Barnaby Jones',
                        email: 'randomemail@email.com',
                        password: 'DontShareWithAnyone',
                        password_confirmation: 'DontShareWithAnyone')

    visit root_path

    click_link 'Log In'

    expect(current_path).to eq(login_path)

    within '#login-form' do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password

      click_button 'Log In'
    end

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("Welcome, #{user.name}!")
  end

  it 'sad path: cannot log in with invalid credentials' do
    user = User.create!(name: 'Barnaby Jones',
                        email: 'randomemail@email.com',
                        password: 'DontShareWithAnyone',
                        password_confirmation: 'DontShareWithAnyone')

    user2 = User.create!(name: 'Geraldine Peters',
                         email: 'anotherrandomemail@email.com',
                         password: 'password',
                         password_confirmation: 'password')

    visit root_path

    click_link 'Log In'

    expect(current_path).to eq(login_path)

    within '#login-form' do
      fill_in 'email', with: user.email
      fill_in 'password', with: user2.password

      click_button 'Log In'
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Sorry, your credentials are bad. Please try again.')
  end
end
