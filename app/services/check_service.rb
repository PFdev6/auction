class CheckService
	def self.check_inprocces(lot, inprocess)
		if inprocess.to_i == 0
			lot.update_attributes(inprocess: false) 
		else
			lot.update_attributes(inprocess: true) 		
		end
	end

end