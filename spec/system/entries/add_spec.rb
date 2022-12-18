require "rails_helper"

RSpec.feature "Adding entries", type: :system do
  include DateAndTimeHelper

  let!(:current_user) { User.create }

  scenario "Adding new general entry" do
    visit "/"

    expect(page).to have_text "Add entry"

    select "Entries::General", from: "entry_type"
    select_date "2022-12-05", from: "entry_date"
    select_time "08:15", from: "entry_start_time"
    select_time "16:45", from: "entry_end_time"
    click_button "Add"

    expect(page).to have_text "Year 2022"
    expect(page).to have_text "Week 49"
    expect(page).to have_text "Mon, 05 Dec General 08:15 16:45 8h 30m 0h 30m 8h 0m 8h 0m + 0h 0m"
  end

  scenario "Adding new vacation entry" do
    visit "/"

    expect(page).to have_text "Add entry"

    select "Entries::Vacation", from: "entry_type"
    select_date "2022-12-05", from: "entry_date"
    click_button "Add"

    expect(page).to have_text "Year 2022"
    expect(page).to have_text "Week 49"
    expect(page).to have_text "Mon, 05 Dec Vacation - - - - 0h 0m 0h 0m + 0h 0m"
    expect(page).to have_text "Vacation Days 1"
  end

  scenario "Adding new manual entry" do
    visit "/"

    expect(page).to have_text "Add entry"

    select "Entries::Manual", from: "entry_type"
    select_date "2022-12-05", from: "entry_date"
    fill_in "entry_time_manual", with: "5.25"
    click_button "Add"

    expect(page).to have_text "Year 2022"
    expect(page).to have_text "Week 49"
    expect(page).to have_text "Mon, 05 Dec Manual - - - - 5h 15m 0h 0m + 5h 15m"
  end
end
