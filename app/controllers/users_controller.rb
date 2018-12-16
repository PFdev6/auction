class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
		@user.lots = Lot.where(user_id: @user.id)
	end

	def edit
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
