require 'test_helper'

class InquirysControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matsuda)
    @other_user = users(:honda)
    @inquiry = inquiries(:hoge)
  end
  
  test "inquiry columns validation" do
    name = "user"
    email = "example@example.com"
    message ="hogehoge"
    get contact_url
    # 無効な名前
    assert_no_difference 'Inquiry.count' do
      post inquirys_path, params: { inquiry: {name: "", email: email, message: message } }
    end
    # 無効なアドレス
    assert_no_difference 'Inquiry.count' do
      post inquirys_path, params: { inquiry: {name: name, email: "user@invalid", message: message } }
    end
    # 無効なメッセージ
    assert_no_difference 'Inquiry.count' do
      post inquirys_path, params: { inquiry: {name: name, email: email, message: "" } }
    end
    # 有効な送信
    assert_difference 'Inquiry.count', 1 do
      post inquirys_path, params: { inquiry: {name: name, email: email, message: message } }
    end
  end
  
  test "should redirect index when non_admin" do
    log_in_as(@other_user)
    get inquirys_path
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when logged in as non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'Inquiry.count' do
      delete inquiry_path(@inquiry)
    end
    assert_redirected_to root_url
  end

end
