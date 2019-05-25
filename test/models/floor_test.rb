require 'test_helper'

class FloorTest < ActiveSupport::TestCase
  test "#to_param returns the slug" do
    slug = "the-slug"
    floor = Floor.new(slug: slug)

    to_param = floor.to_param

    assert_equal(slug, to_param)
  end
end
