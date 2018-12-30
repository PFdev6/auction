module Checkable
  include ActiveSupport::Concern
  
  def check_inprocces(lot)
		if params[:lot][:inprocess].to_i == 0  
			lot.update_attributes(inprocess: false) 
		else
			lot.update_attributes(inprocess: true) 		
		end
	end

  def check_file_count(files)
    if files.size > 3 || files.size == 0 
      flash[:notice] =  'Should be from 1 to 3 images'
      false
    else 
      true
    end      
  end

  def create_lot?(files, lot)
    return true if check_file_count(files) && @lot.valid? && @lot.check_time?
    false
  end

  def check_time?
    if self.lot_end_date >= Time.now.utc
      return true
    end
    false
  end

end