# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:viewing_parties).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
  end

  it 'has secure password' do
    user = User.create(name: 'Barnaby Jones', email: 'barnaby@email.com', password: 'YouHadMeAtPassword', password_confirmation: 'YouHadMeAtPassword')
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('YouHadMeAtPassword')
  end
end
