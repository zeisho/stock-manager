require 'test_helper'

class InquirysIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:matsuda)
    @inquiry = inquiries(:hoge)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get inquirys_path
    assert_template 'inquirys/index'
    assert_select 'div.pagination'
    first_page_of_inquirys = Inquiry.paginate(page: 1)
    first_page_of_inquirys.each do |inquiry|
      assert_select 'span', text: inquiry.name
      assert_select 'span', text: inquiry.email
      assert_select 'span', text: inquiry.message
      assert_select 'a[href=?]', inquiry_path(inquiry), text: "削除"
    end
    assert_difference 'Inquiry.count', -1 do
      delete inquiry_path(@inquiry)
    end
  end
  
end
