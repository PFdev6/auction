class CommentsController < ApplicationController
	before_action :current_comment, only: [:edit, :update, :show]
	def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( parent_id: @parent_id, 
                            commentable_id: @commentable.id,
                            commentable_type: @commentable.class.to_s)
  end
  
  def create
    @commentable = find_commentable
		@comment = @commentable.comments.build(comment_params)
		@comment.user = current_user
		
		if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      flash[:error] = "Error adding comment."
    end
  end
 
  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
	end
	
	def current_comment 
		@current_comment  = Comment.find(params[:id])
	end

	def comment_params
  	params.require(:comment).permit(:msg, :user_id, :parent_id)
  end
end