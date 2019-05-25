class Seat < ApplicationRecord
  belongs_to :section
  has_one :floor, through: :section
  has_one :venue, through: :floor

  def self.find_by_row_number!(row_number)
    row, number = row_number.split("-")

    find_by!(row: row, number: number)
  end

  def row_number
    "#{row}-#{number}"
  end
end
