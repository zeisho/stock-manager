require 'test_helper'

class StockTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:matsuda)
    @stock = @user.stocks.build(name: "Cosmo Sport", user_id: @user.id)
  end

  test "should be valid" do
    assert @stock.valid?
  end

  test "user id should be present" do
    @stock.user_id = nil
    assert_not @stock.valid?
  end

  test "name should be present" do
    @stock.name = "   "
    assert_not @stock.valid?
  end

  test "name should be at most 140 characters" do
    @stock.name = "a" * 141
    assert_not @stock.valid?
  end
  
  test "name should be not blank" do
    @stock.name = " "
    assert_not @stock.valid?
  end
  
  test "order should be most recent first" do
    assert_equal stocks(:rx_vision), @user.stocks.first
  end
  
end
