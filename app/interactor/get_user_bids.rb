class GetUserBids
  include Interactor
  
  def call
    current_user = context.user
    result = []
    bargains = CurrentBargain.includes(:users, :lot ).where(played_out: false)
    bargains.each do |bargain|
      if !bargain.users.select {|user| current_user == user}.empty?
        result << bargain
      end
    end
    context.result = result
  end
end