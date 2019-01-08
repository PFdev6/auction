class UsersController < ApplicationController
	load_and_authorize_resource
	before_action :found_user, only: [:show]
	
	def show
		newlot = params[:newlot]
		@lots = Lot.includes(:tags, :taggings).where(user_id: @user.id)
		@lots = @lots.preload(:user, :current_bargain)
			.paginate(page: params[:page], per_page: 9)
			.order('id ASC')
		if(newlot.present?)
			if newlot == "true"
				@lots = @lots.order('created_at DESC')
				format.html { render @lots }
			end
			if newlot == "false"
				@lots = @lots.order('created_at ASC') 
			end
		end
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
			#.paginate(page: params[:page], per_page: 9)
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
