class ComparisonService

  def self.create_lot?(files, lot)
    return true if check_file_count(files) && lot.valid? && check_time?(lot.lot_end_date)
    false
  end

  def self.update_lot?(lot, time)
    return true if check_time?(time) && lot.current_bargain.id_user_winner.nil? && lot.current_bargain.played_out == false
    false
  end

  def self.check_file_count(files)
    if files.size > 3 || files.size == 0 
      false
    else 
      true
    end      
  end

  def self.check_time?(lot_end_date)
    return false if lot_end_date.nil?
    if lot_end_date >= Time.now + 600 # +10min
      return true
    end 
    false
  end

end