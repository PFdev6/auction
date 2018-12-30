class FilterLotsController < ApplicationController

  def new
    @filter_lot = FilterLot.new
	end

  def show
    @filter_lot = FilterLot.find(params[:id])
	end

  def create
    @filter_lot = FilterLot.create(filter_params)
    redirect_to @filter_lot
	end

	private 
  
  def filter_params
		params.require(:filter_lot).permit(:user_name, :played_out, :autopurchase_price, :start_price)
	end 
end
