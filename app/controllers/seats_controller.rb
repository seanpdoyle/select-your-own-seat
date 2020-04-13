class SeatsController < ApplicationController
  def index
    venue = Venue.find_by!(slug: params[:venue_id])
    floor = venue.floors.find_by!(slug: params[:floor_id])
    sections = floor.sections.includes(:seats)

    render(locals: {
      filter_prices: [5_00, 10_00, 15_00, Float::INFINITY].each_cons(2).to_a,
      venue: venue,
      floor: floor,
      sections: sections,
    })
  end

  def show
    venue = Venue.find_by!(slug: params[:venue_id])
    floor = venue.floors.find_by!(slug: params[:floor_id])
    sections = floor.sections.includes(:seats)
    seat = floor.seats.find_by_row_number!(params[:id])

    render(locals: {
      filter_prices: [5_00, 10_00, 15_00, Float::INFINITY].each_cons(2).to_a,
      venue: venue,
      floor: floor,
      sections: sections,
      seat: seat,
    })
  end
end
