class CurrentBargainsController < ApplicationController
	
  def index 
		@current_bargain = CurrentBargain.all
	end

  private

  def cur_bargain 
    @current_bargain  = Current_bargain.find(params[:id])
  end
  
  def current_bargain
		params.require(:current_bargain).permit(:user, :lot, :current_price)
  end

end
