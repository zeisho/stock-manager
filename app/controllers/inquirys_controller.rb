class InquirysController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]
  
  def new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.inquiry_notice(@inquiry).deliver_now
      flash[:success] = "お問い合わせを送信しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "送信に失敗しました。"
      render "static_pages/contact"
    end
  end
  
  def destroy
    Inquiry.find(params[:id]).destroy
    flash[:success] = "お問い合わせを削除しました。"
    redirect_to inquirys_url
  end
  
  def index
    @inquirys = Inquiry.paginate(page: params[:page])
  end
  
  private
    
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end
    
end
