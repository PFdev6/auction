class CurrentBargain < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
  
  after_find do
    if Time.now >= self.lot.lot_end_date && self.id_user_winner.nil?
      self.lot.isplayedout = false && !self.playedout;
      self.destroy
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
