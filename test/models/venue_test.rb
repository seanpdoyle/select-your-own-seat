require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test "#to_param returns the slug" do
    slug = "the-venue"
    venue = Venue.new(slug: slug)

    to_param = venue.to_param

    assert_equal(slug, to_param)
  end
end
