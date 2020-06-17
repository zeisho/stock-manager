require 'test_helper'

class InquirysControllerTest < ActionDispatch::IntegrationTest
  test "inquiry columns validation" do
    name = "user"
    email = "example@example.com"
    message ="hogehoge"
    get contact_url
    # 無効な名前
    assert_no_difference 'Inquiry.count' do
      post inquirys_path(name: "", email: email, message: message)
    end
    # 無効なアドレス
    assert_no_difference 'Inquiry.count' do
      post inquirys_path(name: name, email: "", message: message)
    end
    # 無効なメッセージ
    assert_no_difference 'Inquiry.count' do
      post inquirys_path(name: name, email: email, message: "")
    end
    # 有効な送信
    assert_difference 'Inquiry.count', 1 do
      post inquirys_path(name: name, email: email, message: message)
    end
  end

end
