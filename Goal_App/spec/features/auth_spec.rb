require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit "users/new"
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      ryan = create(:user)
      visit(user_url(ryan))
      # fill_in("user-username", with: ryan.username)
      # fill_in("user-password", with: ryan.password)
      # click_button "Sign Up"

      expect(page).to have_content(ryan.username)
    end

    it "shows errors and has username pre-filled when provided password is invalid" do
      visit(new_user_url)
      fill_in("user-username", with: "david")
      fill_in("user-password", with: "")
      click_button("Sign Up")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
      expect(find_field("user-username").value).to eq("david")
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
      ryan = create(:user)
      sign_in_as(ryan)

      expect(page).to have_content(ryan.username)
  end

end

feature "logging out" do

  it "begins with logged out state" do
    ryan = create(:user)
    sign_in_as(ryan)
    visit(new_user_url)
    click_button("Sign Out")

    expect(page).to_not have_button("Sign Out")
  end

  it "doesn't show username on the homepage after logout" do
    ryan = create(:user)
    sign_in_as(ryan)

    click_button("Sign Out")

    expect(page).to_not have_content(ryan.username)
  end

end
