require "application_system_test_case"

class VisitorViewsSeatsTest < ApplicationSystemTestCase
  test "visiting the seats index" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: 10_00)
    seat = create(:seat, row: "AA", number: "101", section: section)

    visit("/venues/benedum_center/floors/orchestra/seats")
    click_on_seat("AA-101")

    assert_text("$10.00")
  end

  def click_on_seat(row_number)
    find(%{[aria-label*="#{row_number}"]}).click
  end
end
