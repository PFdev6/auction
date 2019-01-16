class UsersController < ApplicationController
	load_and_authorize_resource
	before_action :found_user, only: %i[show destroy]
	
	def show
		@lots = Lot.includes(:tags, :taggings).where(user_id: @user.id)
		@lots = @lots.preload(:user, :current_bargain)
			.paginate(page: params[:page], per_page: 9)
		@lots = SortByDateService.sort(@lots, params)
	end

	def destroy
		@user.destroy unless @user.isadmin
		redirect_to lots_path, success: 'User successfully destroyed'
	end

	def edit
	end

	def win_lots
		@current_bargain = CurrentBargain.includes(:lot)
			.where(id_user_winner: current_user, played_out: true)
			.paginate(page: params[:page], per_page: 9)
	end

	def user_bids
		@current_bargain = GetUserBids
			.call(user: current_user)
			.result
	end

	def update 
		@user = current_user
		if @user.update_attributes(user_parms)
			redirect_to @user, success: 'User successfully updated'
		else
			render 'edit', danger: 'Lot didn\'t updated'
		end
	end

	private 

	def found_user
		@user = User.find(params[:id])
	end 

	def user_parms
		params.require(:user).permit(:email, :first_name, :second_name, :avatar, :about_users, :nickname, :local)
	end 

end
