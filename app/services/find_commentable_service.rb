class FindCommentableService
  def self.find_commentable(params)
    params.each do |name, value|
      return $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end
end
