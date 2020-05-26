class StocksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @stock = current_user.stocks.build(stock_params)
    if @stock.save
      flash[:success] = "在庫に追加しました！"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @stock.destroy
    flash[:success] = "在庫を削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private
    
    def stock_params
      params.require(:stock).permit(:name)
    end
    
    def correct_user
      @stock = current_user.stocks.find_by(id: params[:id])
      redirect_to root_url if @stock.nil?
    end
  
end
