require 'spec_helper'
require 'rails_helper'

feature "goal making process" do

  let(:ryan) { create(:user) }
  before :each do
    sign_in_as(ryan)
  end

  it "has a new goal page" do
    visit(new_goal_url)

    expect(page).to have_content("Create New Goal")
  end

  it "can create a goal" do
    visit(new_goal_url)
    fill_in("goal-body", with: "complete homework")
    click_button "Create Goal"
    # redirects to user#show page
    expect(page).to have_content("complete homework")
  end

  it "successfully makes goals" do
    10.times do
      create(:goal)
    end
    expect(ryan.goals.count).to eq(10)
  end

  it "redirects user if not signed in" do
    click_button "Sign Out"
    visit(new_goal_url)
    expect(page).to have_content("Sign In")
  end

  it "shows errors when creating empty goal" do
    visit(new_goal_url)
    click_button "Create Goal"
    expect(page).to have_content("Body can't be blank")
  end
end


feature "viewing public/private goals" do

  it "can view all own goals" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    public_goal = ryan.goals.create(
      body: "a public goal",
      private_status: false
    )
    private_goal = ryan.goals.create(
      body: "a private goal"
    )

    sign_in_as(ryan)
    visit user_url(ryan)
    expect(page).to have_content(public_goal.body)
    expect(page).to have_content(private_goal.body)
  end

  it "doesn't show other user private goals" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    public_goal = ryan.goals.create(
      body: "a public goal",
      private_status: false
    )
    private_goal = ryan.goals.create(
      body: "a private goal"
    )
    other_user = User.create(
      username: "other_user",
      password: "password"
    )
    sign_in_as(ryan)
    click_button("Sign Out")
    sign_in_as(other_user)
    visit(user_url(ryan))
    expect(page).to have_content(public_goal.body)
    expect(page).to_not have_content(private_goal.body)
  end
end

feature "editing goals" do
  
  it "has a link on user's show page to edit goals" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    sign_in_as(ryan)
    ryan_goal = ryan.goals.create(body: Faker::Lorem.sentence)
    visit user_url(ryan)
    expect(page).to have_content("Edit")
  end

  it "has fields to edit goal" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    sign_in_as(ryan)
    ryan_goal = ryan.goals.create(body: Faker::Lorem.sentence)
    visit user_url(ryan)
    click_link "Edit", match: :first
    other_user = User.create(
      username: "other_name",
      password: "password"
    )
    expect(page).to have_content("Goal")
    expect(page).to have_content("Complete")
    expect(page).to have_content("Incomplete")
    expect(page).to have_content("Public")
    expect(page).to have_content("Private")
  end

  it "shows edit form for goal" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    sign_in_as(ryan)
    click_link "Edit", match: :first
    expect(find_field("goal-body").value).to eq("I don't know")
  end

  it "successfully edits a goal" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    updated_goal_body = Faker::Lorem.sentence
    sign_in_as(ryan)
    click_link "Edit"
    fill_in "goal-body", with: updated_goal_body
    click_button "Update Goal"
    expect(page).to have_content(ryan.username)
    expect(page).to have_content(updated_goal_body)
  end

  it "shows error on unsuccessful edit" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    sign_in_as(ryan)
    click_link "Edit"
    fill_in "goal-body", with: ""
    click_button "Update Goal"
    expect(page).to have_content("Body can't be blank")
  end

  it "has link to return to user page without editing" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    sign_in_as(ryan)
    click_link "Edit"
    click_link "<< Goals"
    expect(page).to have_content("Edit")
  end

  it "doesn't show other users edit button" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    other_user = User.create(
      username: "other_user",
      password: "password"
    )
    sign_in_as other_user
    visit user_url(ryan)
    expect(page).to_not have_link("Edit")
  end
end


feature "deleting goals" do

  it "has delete button" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    sign_in_as(ryan)
    expect(page).to have_button("Delete")
  end

  it "allows deletion when clicked" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    sign_in_as(ryan)
    click_button("Delete")
    expect(page).to_not have_content(ryan_goal.body)
  end

  it "doesn't show other users delete button" do
    ryan = User.create(
      username: "ryan",
      password: "password"
    )
    ryan_goal = ryan.goals.create(
      body: "I don't know"
    )
    other_user = User.create(
      username: "other_user",
      password: "password"
    )
    sign_in_as other_user
    visit user_url(ryan)
    expect(page).to_not have_button("Delete")
  end
end
