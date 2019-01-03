class LotsController < ApplicationController
	include Checkable

	before_action :current_lot, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index 
		@lots = Lot
		.includes(:current_bargain, :user, :tags, :taggings)
		.where(["name LIKE ?","%#{params[:search]}%"])
		.paginate(page: params[:page], per_page: 9)
		.order(created_at: :desc)
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
		if create_lot?(files, @lot)
			@lot.save
			@lot.load_imgs(files)
			BroadcastMessage.call(bargain: @lot.current_bargain)
			redirect_to @lot, success: 'Lot successfully created'
		else 
			flash[:error] = t('lot.change_end_date') if !@lot.check_time?
			flash[:error] = t('lot.need_img') if !check_file_count(files)
			render 'new', danger: 'Lot didn\'t created'
		end
	end

	def edit
	end

	def destroy 
		@lot.destroy
		redirect_to lots_path, success: 'Lot successfully destroyed'
	end

  def update 
		files = request.parameters[:lot][:files]
		check_inprocces(@lot)
    if @lot.update_attributes(lot_params) &&  @lot.check_time?
      @lot.load_imgs(files) if !files.nil?
			redirect_to @lot, success: 'Lot successfully updated'
		else
			flash[:notice] = t('main.change_end_date') if !@lot.check_time?
			render 'edit', danger: 'Lot didn\'t updated'
		end
	end

	private

	def current_lot
		@lot = Lot.includes(:user).find(params[:id])
	end

	def lot_params
		params.require(:lot).permit(
			:name, 
			:description,
			:autopurchase_price,
			:start_price, 
			:session_lot,
			:all_tags, 
			:lot_end_date
			)
	end

end
