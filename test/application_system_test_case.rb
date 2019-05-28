require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  def click_on_seat(row_number)
    find(%{[aria-label*="#{row_number}"]}).click
  end
end
