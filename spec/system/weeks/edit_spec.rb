require "rails_helper"

RSpec.feature "Editing Weeks", type: :system do
  include DateAndTimeHelper

  let(:current_user) { FactoryBot.create :user, :ready_for_login }

  let!(:entry1) { Entries::General.create!(user: current_user, date: "2022-12-05", start_time: "08:59", end_time: "17:29") }
  let!(:entry2) { Entries::General.create!(user: current_user, date: "2022-12-06", start_time: "08:59", end_time: "17:29") }
  let!(:entry3) { Entries::Manual.create!(user: current_user, date: "2022-12-07", time_manual: "4.50") }

  let(:entry4) { current_user.entries.find_by(date: "2022-12-08") }
  let(:entry5) { current_user.entries.find_by(date: "2022-12-09") }

  before do
    login_as(current_user)
  end

  scenario "Automatically creation of missing entries" do
    visit "/years/2022/weeks/49/edit"

    expect(page).to have_text "Mon, 05 Dec" # existing
    expect(page).to have_text "Tue, 06 Dec" # existing
    expect(page).to have_text "Wed, 07 Dec" # existing
    expect(page).to have_text "Thu, 08 Dec" # new
    expect(page).to have_text "Fri, 09 Dec" # new
  end

  scenario "Updating multiple entries at once" do
    visit "/years/2022/weeks/49/edit"

    select_time "01:00", from: "entries_#{entry1.id}_start_time"
    select_time "23:01", from: "entries_#{entry1.id}_end_time"

    select_time "02:00", from: "entries_#{entry2.id}_start_time"
    select_time "23:02", from: "entries_#{entry2.id}_end_time"

    fill_in "entries_#{entry3.id}_time_manual", with: "3.30"

    select_time "04:00", from: "entries_#{entry4.id}_start_time"
    select_time "23:04", from: "entries_#{entry4.id}_end_time"

    select_time "05:00", from: "entries_#{entry5.id}_start_time"
    select_time "23:05", from: "entries_#{entry5.id}_end_time"

    click_button "Save"

    visit "/"

    expect(page).to have_text "Mon, 05 Dec General 01:00 23:01 22h 0m 0h 45m 21h 15m 8h 0m + 13h 15m"
    expect(page).to have_text "Tue, 06 Dec General 02:00 23:02 21h 2m 0h 45m 20h 17m 8h 0m + 12h 16m"
    expect(page).to have_text "Wed, 07 Dec Manual - - - - 3h 18m 0h 0m + 3h 18m"
    expect(page).to have_text "Thu, 08 Dec General 04:00 23:04 19h 3m 0h 45m 18h 18m 8h 0m + 10h 18m"
    expect(page).to have_text "Fri, 09 Dec General 05:00 23:05 18h 4m 0h 45m 17h 19m 8h 0m + 9h 19m"
  end
end
