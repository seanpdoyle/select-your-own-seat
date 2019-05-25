require "test_helper"

class SeatsControllerTest < ActionDispatch::IntegrationTest
  test "#index when a Cart exists, does not create a new one" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    cart = create(:cart)

    cookies[:cart_token] = cart.token
    get venue_floor_seats_path(venue, floor)

    assert_equal Cart.count, 1
    assert_equal cookies[:cart_token], cart.token
  end

  test "#index when a Cart does not exist, creates a new one" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)

    get venue_floor_seats_path(venue, floor)

    assert_equal Cart.last.token, cookies[:cart_token]
  end
end
