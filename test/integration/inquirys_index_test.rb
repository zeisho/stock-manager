require 'test_helper'

class InquirysIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:matsuda)
    @non_admin = users(:honda)
    @inquiry = inquiries(:hoge)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get inquirys_path
    assert_template 'inquirys/index'
    assert_select 'div.pagination'
    Inquiry.paginate(page: 1).each do |inquiry|
      assert_select 'span', text: inquiry.name
      assert_select 'span', text: inquiry.email
      assert_select 'span', text: inquiry.message
    end
    assert_difference 'Inquiry.count', -1 do
      delete inquiry_path(@inquiry)
    end
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'Inquiry.count' do
      delete inquiry_path(@inquiry)
    end
    assert_redirected_to root_url
  end
  
end
