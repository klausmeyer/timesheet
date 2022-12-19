require "rails_helper"

RSpec.feature "User SignOut", type: :system do
  let!(:current_user) { FactoryBot.create :user, :ready_for_login, password: "password" }

  before do
    login_as(current_user)
  end

  scenario "Signing out" do
    visit "/"

    expect(page).to have_text "Logged in as #{current_user.email}"

    click_link "Logout"

    expect(page).to have_text "Log in"
  end
end
