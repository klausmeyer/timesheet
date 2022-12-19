require "rails_helper"

RSpec.feature "User SignIn", type: :system do
  let!(:current_user) { FactoryBot.create :user, :ready_for_login, password: "password" }

  scenario "Signing in with valid email and password" do
    visit "/"

    expect(page).to have_text "Log in"

    fill_in "user_email",    with: current_user.email
    fill_in "user_password", with: current_user.password
    click_button "Log in"

    expect(page).to have_text "Dashboard"
  end
end
