class ComparisonService

  def self.create_lot?(files, lot)
    return true if check_file_count(files) && lot.valid? && check_time?(lot)
    false
  end

  def self.update_lot?(lot)
    return true if lot.valid? && check_time?(lot) && lot.current_bargain.id_user_winner.nil?
    false
  end

  def self.check_file_count(files)
    if files.size > 3 || files.size == 0 
      false
    else 
      true
    end      
  end

  def self.check_time?(lot)
    if lot.lot_end_date >= Time.now + 600 # +10min
      return true
    end 
    false
  end

end