require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matsuda)
    @other_user = users(:honda)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path,count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end
  
  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", full_title("Sign up")
  end
  
  test "layout links when logged in" do
    log_in_as(@other_user)
    get root_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", user_path(@other_user)
    assert_select "a[href=?]", edit_user_path(@other_user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path, count: 0
  end
  
  test "layout links when admin" do
    log_in_as(@user)
    get root_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
  
end
