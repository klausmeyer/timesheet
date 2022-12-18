require "rails_helper"

RSpec.feature "Listing entries", type: :system do
  let(:current_user) { User.create }
  let(:other_user)   { User.create }

  before do
    current_user.entries << Entries::General.new(date: "2022-12-05", start_time: "08:59", end_time: "17:29")
    current_user.entries << Entries::General.new(date: "2022-12-06", start_time: "08:59", end_time: "17:29")
    current_user.entries << Entries::General.new(date: "2022-12-07", start_time: "08:59", end_time: "17:29")
    current_user.entries.last.delete

    other_user.entries << Entries::Vacation.new(date: "2022-12-05")
  end

  scenario "Listing all not deleted entries owned by the current user" do
    visit "/"

    # Basic checks for the layout
    expect(page).to have_text "Dashboard"
    expect(page).to have_text "Year 2022"
    expect(page).to have_text "Week 49"

    # Positive test: Entries owned by current user
    expect(page).to have_text "Mon, 05 Dec General"
    expect(page).to have_text "Tue, 06 Dec General"

    # Negative test: Deleted entry
    expect(page).not_to have_text "Wed, 07 Dec Vacation"

    # Negative test: Entry owned by other user
    expect(page).not_to have_text "Mon, 05 Dec Vacation"
  end
end
