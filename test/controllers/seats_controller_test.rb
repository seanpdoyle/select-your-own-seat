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

  test "#index when including sections when filtering by price" do
    maximum = 10_00
    price = maximum
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: price)
    create(:seat, section: section)

    get venue_floor_seats_path(venue, floor, maximum: maximum)

    assert_select %{g[opacity="1.0"]}
    assert_select %{g:not([aria-hidden])}
  end

  test "#index when excluding sections when filtering by price" do
    maximum = 5_00
    price = 10_00
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    section = create(:section, floor: floor, price: price)
    create(:seat, section: section)

    get venue_floor_seats_path(venue, floor, maximum: maximum)

    assert_select %{g[opacity="0.3"]}
    assert_select %{g[aria-hidden="true"]}
  end

  test "#index with a ?maximum query parameter" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)
    maximum = 10_00

    get venue_floor_seats_path(venue, floor, maximum: maximum)

    assert_select %{input[type="radio"][value="#{maximum}"][checked]}
  end

  test "#index without a ?maximum query parameter" do
    venue = create(:benedum_center)
    floor = create(:orchestra, venue: venue)

    get venue_floor_seats_path(venue, floor)

    assert_select %{input[type="radio"][value="1500"][checked]}
  end
end
