class LotsController < ApplicationController

	before_action :current_lot, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	def index 
		@lots = Lot.includes(:current_bargain, :user, :tags, :taggings).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
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
		if check_file_count(files) && @lot.valid? && @lot.check_time?  
			@lot.save
      @lot.load_imgs(files)
			redirect_to @lot, success: 'Lot successfully created'
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
    files = request.parameters[:lot][:files]
    if @lot.update_attributes(lot_params) &&  @lot.check_time?
      @lot.load_imgs(files) if !files.nil?
			redirect_to @lot, success: 'Lot successfully updated'
		else
			flash[:notice] = t('main.change_end_date') if !@lot.check_time?
			render 'edit', danger: 'Lot didn\'t updated'
		end
	end

	private 
  def check_file_count(files)
    if files.size > 3 || files.size == 0 
      flash[:notice] =  'Should be from 1 to 3 images'
      false
    else 
      true
    end      
  end

	def current_lot
		@lot = Lot.find(params[:id])
	end

	def lot_params
		params.require(:lot).permit(:name, :description,:autopurchase_price, :start_price, :session_lot, :all_tags, :lot_end_date)
	end

end
