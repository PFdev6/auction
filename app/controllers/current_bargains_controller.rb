class CurrentBargainsController < ApplicationController
  before_action :cur_bargain, only: [:edit, :update, :show]
  
  def index 
		@current_bargain = CurrentBargain.all
	end

  def show
  
  end

  private

  def cur_bargain 
    @current_bargain  = CurrentBargain.find(params[:id])
  end
  
  def current_bargain
		params.require(:current_bargain).permit(:user, :lot, :current_price)
  end

end
