class FilterLot < ApplicationRecord
  def search_lots
		lots = Lot.includes(:current_bargain, :user, :tags, :taggings).all 

    if user_name.present?
      user_search = User.find_by(["nickname LIKE ?","%#{user_name}%"])
      lots = lots.where(user:user_search)
    end
    lots = lots.where(["autopurchase_price >= ?", autopurchase_price]) if autopurchase_price.present?
    lots = lots.where(["start_price >= ?", start_price]) if start_price.present?
    if played_out.present?
      lots = lots.select do |lot|
        lot.current_bargain.present?
      end
      lots = lots.select do |lot|
        lot.current_bargain.played_out == played_out
      end
    end
    lots
  end 
end
