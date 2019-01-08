class SortByDateService
  def self.sort(lots, params)
    return lots.order('created_at DESC') if params.nil?
    if(params.present?)
      if params == 'true'
        return lots.order('created_at DESC') 
      end
      if params == 'false'
        return lots.order('created_at ASC') 
      end
    end
  end
end