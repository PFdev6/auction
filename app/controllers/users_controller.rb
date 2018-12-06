class UsersController < ApplicationController
	
	def show
		@user = current_user
		@user.lots = Lot.where(user_id: @user.id)
	end

end
