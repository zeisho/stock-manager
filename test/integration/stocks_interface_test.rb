require 'test_helper'

class StocksInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matsuda)
  end
  
  test "stocks interface" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Stock.count' do
      post stocks_path, params: { stock: {name: ""} }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    name = "VISION COUPE"
    category = "その他"
    maker = "その他"
    assert_difference 'Stock.count', 1 do
      post stocks_path, params: { stock: {name: name} }
    end
    assert_redirected_to root_url
    follow_redirect!
    get user_path(@user)
    assert_match name, response.body
    assert_match category, response.body
    assert_match maker, response.body
    # 在庫の削除
    assert_select 'a', text: '削除'
    first_stock = @user.stocks.paginate(page: 1).first
    assert_difference 'Stock.count', -1 do
      delete stock_path(first_stock)
    end
    # 別ユーザーの削除リンクないか
    get user_path(users(:honda))
    assert_select 'a', text: '削除', count: 0
  end
  
  test "stock sidebar count" do
    log_in_as(@user)
    get root_url
    assert_match "在庫数：#{@user.stocks.count}", response.body
    other_user = users(:toyoda)
    log_in_as(other_user)
    get root_url
    assert_match "在庫数：0", response.body
    other_user.stocks.create!(name: "TOYOTA 800")
    get root_url
    assert_match "在庫数：1", response.body
  end
  
end
