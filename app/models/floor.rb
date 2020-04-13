class Floor < ApplicationRecord
  belongs_to :venue

  has_many :sections
  has_many :seats, through: :sections

  def filter_prices
    [5_00, 10_00, 15_00, Float::INFINITY].each_cons(2).to_a
  end

  def to_param
    slug
  end
end
