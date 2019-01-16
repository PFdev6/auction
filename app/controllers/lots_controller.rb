class LotsController < ApplicationController
	load_and_authorize_resource
	
	before_action :current_lot, only: %i[edit update show destroy]
	before_action :authenticate_user!, except: %i[index show]

	def index
		#newlots = params[:newlots]
		@lots = Lot
			.includes(:user, :tags, :current_bargain, :taggings)
		@lots = SearchLotsService.sort(@lots, params)
		@lots = SortByDateService.sort(@lots, params).paginate(page: params[:page], per_page: 9)
	end

	def show
	end

	def new
		@lot = current_user.lots.build
	end

	def create
	  @lot = current_user.lots.build(lot_params)
		files = request.parameters[:lot][:files]
		files = [] if files.nil?
		if ComparisonService.create_lot?(files, @lot)
			@lot.save
			@lot.load_imgs(files)
			BroadcastMessage.call(bargain: @lot.current_bargain)
			redirect_to @lot, success: 'Lot successfully created'
		else 
			flash[:error] = t('lot.sp_more_than_ap') unless ComparisonService.check_price?(@lot)
			flash[:error] = t('lot.change_end_date') unless ComparisonService.check_time?(@lot.lot_end_date)
			flash[:error] = t('lot.need_img') unless ComparisonService.check_file_count(files)
			render 'new', danger: 'Lot didn\'t created'
		end
	end

	def edit
		if current_user.isadmin? && params[:inprocess].present?
			CheckService.check_inprocces(@lot, params[:inprocess]) 
		end
		respond_to do |format|
			format.html { render :edit }
		end
	end

	def destroy 
		@lot.destroy
		redirect_to lots_path, success: 'Lot successfully destroyed'
	end

	def update
		return redirect_to @lot, danger: 'Bargain is stopped' unless @lot.inprocess
		
		files = request.parameters[:lot][:files]
		if current_user.isadmin?
			CheckService.check_inprocces(@lot, params[:lot][:inprocess]) 
		end
		if params[:lot][:id].present?
			@lot.update_attributes(lot_params)
			@lot.load_imgs(files) unless files.nil?
			return redirect_to @lot, success: 'Lot successfully updated'
		end
		if ComparisonService.update_lot?(@lot, params[:lot][:lot_end_date].to_time)
			@lot.update_attributes(lot_params) 
			@lot.load_imgs(files) unless files.nil?
			BroadcastMessage.call(bargain: @lot.current_bargain)
			redirect_to @lot, success: 'Lot successfully updated'
		else
			flash[:error] = t('lot.lot_stopped') unless @lot.inprocess 
			flash[:error] = t('lot.sp_more_than_ap') unless ComparisonService.check_price?(@lot)
			flash[:error] = t('main.change_end_date') unless ComparisonService.check_time?(params[:lot][:lot_end_date].to_time)
			flash[:error] = 'Lot didn\'t updated'
			render 'edit'
		end
	end

	private

	def current_lot
		@lot = Lot.find(params[:id])
	end

	def lot_params
		params.require(:lot).permit(
			:name, 
			:description,
			:autopurchase_price,
			:start_price, 
			:session_lot,
			:all_tags, 
			:lot_end_date,
		)
	end
end
