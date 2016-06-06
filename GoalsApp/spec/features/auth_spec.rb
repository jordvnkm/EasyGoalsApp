require 'rails_helper'
include AuthFeaturesHelper

feature "the signup process" do
  before :each do
    visit "/users/new"
  end


  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end
  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      sign_up_as_john
      expect(page).to have_content("john")
      expect(current_path).to eq("/goals")
    end
  end

end

feature "logging in" do
  User.create!(username: "john", password: "abcdef")
  it "shows username on the homepage after login" do
  sign_in_as_john
  expect(page).to have_content("john")
  expect(current_path).to eq("/goals")
end
end

feature "logging out" do
  before :each do
    sign_up_as_john
    click_button "Sign Out"
  end
  it "begins with logged out state" do
    expect(page).to have_content "Sign In"
  end
  it "doesn't show username on the homepage after logout" do
    expect(page).to_not have_content "john"
  end
end
