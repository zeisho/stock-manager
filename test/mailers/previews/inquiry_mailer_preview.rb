# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  
  def inquiry_notice
    user = User.first
    message = "hogehoge"
    inquiry = Inquiry.new(name: user.name, email: user.email, message: message)
    InquiryMailer.inquiry_notice(inquiry)
  end

end
