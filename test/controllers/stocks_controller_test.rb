require 'test_helper'

class StocksControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @stock = stocks(:roadster)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Stock.count' do
      post stocks_path, params: { stock: { name:"Cosmo Sport"}}
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Stock.count' do
      delete stock_path(@stock)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong stock" do
    log_in_as(users(:matsuda))
    stock = stocks(:s2000)
    assert_no_difference 'Stock.count' do
      delete stock_path(stock)
    end
    assert_redirected_to root_url
  end
  
end
