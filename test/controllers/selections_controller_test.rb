require "test_helper"

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  test "#create when a Seat is not selected" do
    seat = create(:seat)

    post seat_selections_path(seat)

    assert_equal SeatSelection.pluck(:seat_id), [seat.id]
  end

  test "#create when a Seat is already selected" do
    seat_selection = create(:seat_selection)
    cart = seat_selection.cart
    seat = seat_selection.seat
    cookies[:cart_token] = cart.token

    post seat_selections_path(seat)

    assert_equal cart.seats.ids, [seat.id]
  end

  test "#destroy when a Seat is already selected" do
    seat_selection = create(:seat_selection)
    cart = seat_selection.cart
    seat = seat_selection.seat
    cookies[:cart_token] = cart.token

    delete seat_selection_path(seat, seat_selection)

    assert_equal cart.seats.ids, []
  end
end
