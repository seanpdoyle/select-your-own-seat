require "application_system_test_case"

class VisitorSelectsSeatTest < ApplicationSystemTestCase
  test "visiting the seat page" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: 10_00)
    seat = create(:seat, row: "AA", number: "101", section: section)

    visit("/venues/benedum_center/floors/orchestra/seats/AA-101")
    click_on("Select")

    within("#cart-summary") do
      assert_text "$10.00"
    end
  end
end
