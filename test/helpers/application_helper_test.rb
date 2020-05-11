require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Stock Manager App"
    assert_equal full_title("Help"), "Help | Stock Manager App"
  end
end