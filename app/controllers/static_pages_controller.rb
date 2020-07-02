class StaticPagesController < ApplicationController
  def home
    @stock = current_user.stocks.build if logged_in?
  end

  def help
  end

  def about
  end
  
  def contact
    @inquiry = Inquiry.new
  end
end
