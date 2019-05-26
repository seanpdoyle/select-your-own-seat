require "application_system_test_case"

class VisitorChangesFloorTest < ApplicationSystemTestCase
  test "visiting the balcony from the orchestra" do
    benedum_center = create(:benedum_center)
    orchestra = create(:orchestra, venue: benedum_center)
    balcony = create(:balcony, venue: benedum_center)
    front = create(:section, floor: orchestra)
    back = create(:section, floor: balcony)
    orchestra_seat = create(:seat, section: front, row: "AA", number: "1")
    balcony_seat = create(:seat, section: back, row: "ZZ", number: "1")

    visit "/venues/benedum_center/floors/orchestra/seats"
    click_on balcony.name

    assert_selector seat_selector(balcony_seat)
    refute_selector seat_selector(orchestra_seat)
  end

  def seat_selector(seat)
    %{a[aria-label="#{seat.row_number}"]}
  end
end
