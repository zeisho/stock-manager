require 'test_helper'

class InquiryMailerTest < ActionMailer::TestCase
  
  test "Inquiry notice" do
    user = users(:matsuda)
    inquiry = Inquiry.new(name: user.name, email: user.email, message: "hoge" )
    mail = InquiryMailer.inquiry_notice(inquiry)
    assert_equal "inquiry notice", mail.subject
    assert_equal ["dream_08026672964@yahoo.co.jp"], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end
  
end
