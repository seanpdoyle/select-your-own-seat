require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "#include? returns true when a seat is selected" do
    seat_selection = create(:seat_selection)
    seat = seat_selection.seat
    cart = seat_selection.cart

    included = cart.include?(seat)

    assert included, "cart includes selected seat"
  end

  test "#include? returns false when a seat is not yet selected" do
    seat = create(:seat)
    cart = create(:cart)

    included = cart.include?(seat)

    refute included, "cart includes selected seat"
  end
end
