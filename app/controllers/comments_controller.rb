class CommentsController < ApplicationController
	before_action :current_comment, only: [:edit, :update, :show]
	def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( 
      parent_id: @parent_id, 
      commentable_id: @commentable.id,
      commentable_type: @commentable.class.to_s
      )
  end
  
  def create
    
    @commentable = find_commentable
		@comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.msg.empty?
      flash[:error] = t 'comment_is_empty'      
      return redirect_to @commentable
      
    end 

    if stopped?(params[:current_bargain_id])
      flash[:error] = t 'bargain_was_stopped'      
    else
      if @comment.save
        flash[:notice] = t 'successfully_created_comment'
      else
        flash[:error] = t 'error_adding_comment'
      end 
    end

    redirect_to @commentable
  end
 
  private

  def stopped?(bargain_id)
    !CurrentBargain.find_by(id: bargain_id).lot.inprocess
  end

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