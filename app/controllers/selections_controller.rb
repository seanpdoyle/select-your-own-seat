class SelectionsController < ApplicationController
  def create
    seat = Seat.find(params[:seat_id])

    Current.cart.seat_selections.create_or_find_by(seat: seat)

    redirect_to venue_floor_seats_url(seat.venue, seat.floor)
  end

  def destroy
    seat = Seat.find(params[:seat_id])

    Current.cart.seat_selections.where(seat_id: seat).destroy_all

    redirect_to venue_floor_seats_url(seat.venue, seat.floor)
  end
end
