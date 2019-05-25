class Floor < ApplicationRecord
  belongs_to :venue

  has_many :sections
  has_many :seats, through: :sections

  def to_param
    slug
  end
end
