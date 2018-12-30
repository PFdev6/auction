module Clearable
  include ActiveSupport::Concern
  
  def clear_job(bargain)
    return if bargain.nil?
    job = Delayed::Job.find_by(id: bargain.delayed_job_id)
    job.destroy if job.present?
    bargain.update_attributes(delayed_job_id: nil) 
  end 

end