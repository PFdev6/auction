class SessionLotsController < ApplicationController
	
  def index 
		@session_lot = SessionLot.all
	end
  
	def create 
		@session_lot = current_user.lot.session_lots.build(session_lot_parms)
    @session_lot.save
		redirect_to @session_lot, success: 'Session lot successfully created'
  end
  
  private

  def current_session
    @session_lot  = Session_lot.find(params[:id])
  end
  
  def session_lot_parms
		params.require(:session_lot).permit(:user, :lot, :current_price)
  end

end
