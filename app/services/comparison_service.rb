class ComparisonService

  def self.create_lot?(files, lot)
    return true if check_price?(lot) && check_file_count(files) && lot.valid? && check_time?(lot.lot_end_date)

    false
  end

  def self.update_lot?(lot, time)
    return true if check_price?(lot) && check_time?(time) && lot.current_bargain.id_user_winner.nil? && lot.current_bargain.played_out && lot.inprocess

    false
  end

  def self.check_file_count(files)
    if files.size > 3 || files.size == 0 
      false
    else
      true
    end
  end

  def self.check_price?(lot)
    return true if lot.start_price < lot.autopurchase_price

    false
  end

  def self.check_time?(lot_end_date)
    return false if lot_end_date.nil?
    return true if lot_end_date >= Time.now + 600 # +10min

    false
  end

end