require "application_system_test_case"

class VisitorUnselectsSeatTest < ApplicationSystemTestCase
  test "visiting the seat page" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: 10_00)
    seat = create(:seat, row: "AA", number: "101", section: section)

    visit "/venues/benedum_center/floors/orchestra/seats/AA-101"
    click_on "Select"
    click_on "Remove"

    within "#cart-summary" do
      assert_no_text "$10.00"
    end
  end

  test "from the details dialog of an already selected seat" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: 10_00)
    seat = create(:seat, row: "AA", number: "101", section: section)

    visit "/venues/benedum_center/floors/orchestra/seats"
    click_on_seat "AA-101"
    click_on "Select"
    click_on_seat "AA-101"
    within("dialog") { click_on "Remove" }

    within "#cart-summary" do
      assert_no_text "$10.00"
    end
  end
end
