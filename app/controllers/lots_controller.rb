class LotsController < ApplicationController
	before_action :current_lot, only: [:edit, :update, :show, :destroy]

	def index 
		@lots = Lot.paginate(:page => params[:page], :per_page => 2)
	end

	def show 
	end

	def new 
		@lot = Lot.new 
	end

	def create 
		@lot  = Lot.new(lot_parms)
		p @lot.valid?
		if @lot.save
			redirect_to @lot, success: 'Lot successfully created'
		else 
			render 'new',  danger: 'Lot didn\'t created'
		end
	end

	def edit
	end

	def destroy 
		@lot.destroy
		redirect_to  lots_path, success: 'Lot successfully destroyed'
	end

	def update 
		if @lot.update_attributes(lot_parms)
			redirect_to @lot, success: 'Lot successfully updated'
		else
			render 'edit', danger: 'Lot didn\'t updated'
		end
	end

	private 
	
	def current_lot
		@lot = Lot.find(params[:id])
	end

	def lot_parms
		params.require(:lot).permit(:name, :description, :start_price, :main_image, :all_tags)
	end
end
