class LotsController < ApplicationController
	
	before_action :current_lot, only: [:edit, :update, :show, :destroy]
	
	def index 
		@lots = Lot.all
	end

	def show 
	end

	def new 
		@lot = Lot.new
	end

	def create 
		@lot  = Lot.new(lot_parms)
		if @lot.save
			redirect_to @lot
		else 
			render new
		end
	end

	def edit
	end

	def destroy 
		@lot.destroy
		redirect_to  lots_path
	end

	def update 
		if @lot.update_attributes(lot_parms)
			redirect_to @lot
		else
			render edit
		end
	end

	private 
	
	def current_lot
		@lot = Lot.find(params[:id])
	end

	def lot_parms
		params.require(:lot).permit(:name, :description, :start_price)
	end
end
