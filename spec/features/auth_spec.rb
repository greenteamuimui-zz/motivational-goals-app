require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
  end

  scenario "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  scenario "has a new user page" do
    expect(page).to have_content "Username"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", :with => "jack@123.com"
      fill_in "Password", with: "1234567"
      click_on "Sign Up"
      expect(page).to have_content "jack@123.com"
    end

  end

end

feature "logging in" do
  before(:each) do
    User.create(username: 'jackie', password: '1234567')
  end

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in "Username", with: "jackie"
    fill_in "Password", with: "1234567"
    click_on "Log In"

    expect(page).to have_content "jackie"
  end

end

feature "logging out" do
  before(:each) do
    User.create(username: 'jackie', password: '1234567')
    visit new_session_url
    fill_in "Username", with: "jackie"
    fill_in "Password", with: "1234567"
    click_on "Log In"
  end

  scenario "begins with a logged out state" do
    expect(page).to have_content "Log Out"
  end

  scenario "doesn't show username on the homepage after logout" do
    click_on "Log Out"
    expect(page).to_not have_content "jackie"
  end
end
