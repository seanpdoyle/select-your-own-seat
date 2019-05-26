require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def click_on_seat(row_number)
    find(%{[aria-label*="#{row_number}"]}).click
  end
end
