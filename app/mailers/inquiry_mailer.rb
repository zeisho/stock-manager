class InquiryMailer < ApplicationMailer
  
  def inquiry_notice(inquiry)
    @inquiry = inquiry
    mail to: "dream_08026672964@yahoo.co.jp", subject: "inquiry notice"
  end
  
end
