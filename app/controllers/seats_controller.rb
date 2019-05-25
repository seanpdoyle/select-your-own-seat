class SeatsController < ApplicationController
  def index
    venue = Venue.find_by!(slug: params[:venue_id])
    floor = venue.floors.find_by!(slug: params[:floor_id])
    sections = floor.sections

    render(locals: {
      venue: venue,
      floor: floor,
      sections: sections,
    })
  end

  def show
    venue = Venue.find_by!(slug: params[:venue_id])
    floor = venue.floors.find_by!(slug: params[:floor_id])
    sections = floor.sections
    seat = floor.seats.find_by_row_number!(params[:id])

    render(locals: {
      venue: venue,
      floor: floor,
      sections: sections,
      seat: seat,
    })
  end
end
