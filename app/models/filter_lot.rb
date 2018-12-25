class FilterLot < ApplicationRecord
  def search_lots
		lots = Lot.includes(:current_bargain, :user, :tags, :taggings).all#.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    #user = User.where(["nickname like ?"], ["%#{params:user_name}"])
    user_name.downcase
    lots = lots.select do |lot| 
      lot.user.nickname.downcase == user_name  
    end if user_name.present?
    
    lots = lots.where(["autopurchase_price >= ?", autopurchase_price]) if autopurchase_price.present?
    lots = lots.where(["start_price >= ?", start_price]) if start_price.present?
    #lots = lots.where(["nickname like ?"], ["%#{user_name}"]) if user_name.present?

    if played_out.present?
      lots = lots.select do |lot|
        lot.current_bargain.present?
      end

      lots = lots.select do |lot|
        lot.current_bargain.played_out == played_out
      end
    end

    return lots
  end 
end
