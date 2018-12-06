require "net/http"
require "uri"
class LotsController < ApplicationController

	before_action :current_lot, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index 
		@lots = Lot.paginate(:page => params[:page], :per_page => 20)
	end

	def show 
	end

	def new 
		@lot = current_user.lots.build
	end

	def create 
		@lot = current_user.lots.build(lot_parms)
		if @lot.valid? && @lot.lot_end_date.to_date > (Time.now + 600).to_date  
			@lot.save
			# if @lot.isplayedout?
			# 	uri = URI.parse('localhost:3000/session_lots?=')#need correct
			# 	response = Net::HTTP.post_form(uri, {user: @lot.user, lot: @lot, current_price: @lot.start_price})
			# else
				redirect_to @lot, success: 'Lot successfully created'
			#end
		else 
			render 'new',  danger: 'Lot didn\'t created'
		end
	end

	def edit
	end

	def destroy 
		@lot.destroy
		redirect_to lots_path, success: 'Lot successfully destroyed'
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
		params.require(:lot).permit(:name, :description, :start_price, :main_image, :isplayedout, :session_lot, :all_tags, :lot_end_date)
	end
end
