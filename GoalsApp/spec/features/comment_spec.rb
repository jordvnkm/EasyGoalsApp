require 'rails_helper'
include AuthFeaturesHelper

feature "adding comment process" do
  before :each do
    sign_up_as_john
  end

  it "there is an add comment form on the goal show page" do
    make_goal("wake up early", true)
    expect(page).to have_content 'Add Comment'
  end

  it "shows the goal show page on submit" do
    make_goal("wake up early", true)
    fill_in 'Comment', with: 'yippy'
    click_button 'Add Comment'
    expect(page).to have_content 'john'
  end

  it "after submitting comment; new comment is added to list" do
    make_goal("wake up early", true)
    fill_in 'Comment', with: 'yippy-chai-eh'
    click_button 'Add Comment'
    expect(page).to have_content 'yippy-chai-eh'
  end

  it "validates presence of comment body" do
    make_goal("wake up early", true)
    click_button 'Add Comment'
    expect(page).to have_content "Body can't be blank"
  end


  feature "Deleting comments" do
    before :each do
      sign_out
      sign_up_as_john
      make_goal("wake up early", true)
      fill_in 'Comment', with: "there are 10 kinds of people. Those who understand binary and those who dont."
      click_button "Add Comment"
    end

    it "displays a remove button next to each comment" do
      expect(page).to have_button 'Remove Comment'
    end

    it "shows the user show page on click" do
      click_button 'Remove Comment'
      expect(page).to have_content 'john'
    end

    it "removes the comment on click" do
      click_button 'Remove Comment'
      expect(page).to_not have_content 'there are 10 kinds of people. Those who understand binary and those who dont.'
    end
  end
end
