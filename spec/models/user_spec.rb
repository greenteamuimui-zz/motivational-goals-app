require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: 'Cherry', password: '1234567')}

  describe 'validations for User model' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_length_of(:password).is_at_least(6) }
  end

  describe "validations for User model associations" do
    it {should have_many(:goals)}
    it {should have_many(:authored_comments)}
    it {should have_many(:gained_comments).through(:goals)}
  end

  describe "#ensure_session_token" do
    it "creates a session token before validation" do
      user.valid?
      expect(user.session_token).to_not be_nil
    end
  end

  describe "#reset_session_token!" do
    it "sets a new session token on the user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
     expect(user.reset_session_token!).to eq(user.session_token)
   end
  end

  describe "#is_password?" do
    it "validates the password entered is correct" do
      user.valid?
      expect(user.is_password?('1234567')).to be(true)
    end

    it "verifies password when user enters an invalid password" do
      expect(user.is_password?('1234212312367')).to be(false)
    end

  end

  describe "#self.find_by_credentials" do
    it "finds the right user by username and password" do
      expect(User.find_by_credentials('Cherry', '1234567')).to eq(user)
    end
  end

  
end
