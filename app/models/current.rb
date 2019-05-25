class Current < ActiveSupport::CurrentAttributes
  attribute :cart

  def seat_selections
    cart.seat_selections
  end
end
