class SortByDateService
  def self.sort(lots, params)
    return lots.order('lots.created_at desc') if params[:sort].nil?
    return lots.order('lots.created_at desc') if params[:sort] == 'new_lots'
    return lots.order('lots.created_at asc') if params[:sort] == 'old_lots'
    return lots.left_outer_joins(:user).includes(:user).order('user_id') if params[:sort] == 'by_users'
    return lots.left_outer_joins(:user).includes(:user).where('"users"."likes" > 9').order('created_at desc') if params[:sort] == 'top'# VSE OCHEN PLOHO 4 utra
  end
end
