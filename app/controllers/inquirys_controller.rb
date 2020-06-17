class InquirysController < ApplicationController
  
  def new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.inquiry_notice(@inquiry).deliver_now
      flash[:success] = "お問い合わせを送信しました。"
      redirect_to root_url
    else
      flash[:danger] = "送信に失敗しました。"
      render "static_pages/contact"
    end
  end
  
  private
    
    def inquiry_params
      params.permit(:name, :email, :message)
    end
    
end
