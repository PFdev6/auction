class SearchLotsService
  def self.sort(lots, params)
    if params[:user_name].present?
      user_search = User.find_by(['nickname ilike ?', "%#{params[:user_name]}%"])
      lots = lots.where(user: user_search)
    end
    lots = lots.where(["autopurchase_price >= ?", params[:autopurchase_price]]) if params[:autopurchase_price].present?
    lots = lots.where(["start_price >= ?", params[:start_price]]) if params[:start_price].present?
    if params[:played_out].present?
      played_out = params[:played_out] == "on" ? true : false
      lots = lots.joins(:current_bargain).where({current_bargains: { played_out: played_out }}).order('lots.created_at desc')
    end
    lots
  end 
end