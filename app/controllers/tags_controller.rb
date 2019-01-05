class TagsController  < ApplicationController	
	def show
    @tag = Tag.find_by(name: params[:id])
    if @tag.nil?
      nil
    else
      @lots = @tag.lots.includes( :user, :tags, :taggings)    
    end
	end
end