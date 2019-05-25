class Cart < ApplicationRecord
  has_secure_token

  has_many :seat_selections
  has_many :seats, through: :seat_selections
end
