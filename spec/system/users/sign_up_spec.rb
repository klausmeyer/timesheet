require "rails_helper"

RSpec.feature "User SignUp", type: :system do
  let!(:current_user) { FactoryBot.create :user, password: "password" }

  scenario "Signing up" do
    visit "/"

    expect(page).to have_text "Log in"

    click_link "Sign up"

    expect(page).to have_text "Sign up"

    fill_in "user_email", with: "new-email@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_text ""
  end
end
