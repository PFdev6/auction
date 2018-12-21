class CurrentBargain < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
  
  after_find do
    if Time.now >= self.lot.lot_end_date && self.id_user_winner.nil?
      self.lot.isplayedout = false;
      self.destroy
    end
  end

  def new_price_for_bargain(new_price, user)
    CurrentBargain.transaction do
      current_price = self.current_price
      if(new_price >= self.lot.autopurchase_price)
        self.playedout = true
        self.id_user_winner = user
      elsif(new_price > current_price)
        self.update_attributes(current_price: new_price, id_user_winner: user)
        self.users << user
      else 
        raise ActiveRecord::Rollback
        return 'current_price: #{current_price.to_s}'
      end
      return 'Complete'
    end
  end

  def determine_winner
    CurrentBargain.transaction do
      if(self.id_user_winner)
        self.playedout = true
      else
        self.destroy
        #msg!!!!
      end
    end
  end
end
