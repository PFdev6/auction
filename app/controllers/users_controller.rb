class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
		@user.lots = Lot.includes(:tags, :taggings, :current_bargain).where(user_id: @user.id)
	end

	def edit
	end

	def win_lots
		@current_bargain = CurrentBargain.includes(:lot).where(id_user_winner: current_user, played_out: true)
	end

	def like_it
		user = User.find_by(id: params[:user_id])
		user.update_attributes(likes:user.likes+1)
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
	def user_parms
		params.require(:user).permit(:email, :first_name, :second_name, :avatar, :about_users, :nickname, :local)
	end 

end
