require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:matsuda)
  end
  
  test "password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # 無効なアドレス
    post password_resets_path, params: { password_reset: { email: "" }}
    assert_not flash.empty?
    # 有効なアドレス
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # 再設定フォームテスト
    user = assigns(:user)
    # 無効なアドレス
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    # 無効なユーザー
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # アドレス有効、トークン無効
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
    # アドレス、トークン共に有効
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # 無効なパスワードとパスワードテスト
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                    user: { password: "foobaz",
                          password_confirmation: "barquux"
    }}
    assert_select 'div#error_explanation'
    # 空のパスワード
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                    user: {password: "",
                          password_comfirmation: ""
      }}
    assert_select 'div#error_explanation'
    # 有効なパスワードとパスワードテスト
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                    user: {password: "foobaz",
                          password_comfirmation: "foobaz"
      }}
    assert_nil user.reload.reset_digest
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
  
  test "expired token" do
    get new_password_reset_path
    post password_resets_path,
      params: { password_reset: { email: @user.email } }
    
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
        params: { email: @user.email,
                    user: {password: "foobaz",
                          password_comfirmation: "foobaz"
      }}
    assert_response :redirect
    follow_redirect!
    assert_match "パスワード変更の有効期限が切れました。", response.body
  end
  
end
