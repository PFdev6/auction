class TagsController  < ApplicationController	
	def show
    @tag = Tag.find_by(name: params[:id])
    if @tag.nil?
      d
      nil
    else
      @lots = @tag.lots.includes( :user, :tags, :taggings)    
    end
	end
end