class CommentsController < ApplicationController
	before_action :current_comment, only: %i[edit update show destroy]
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = FindCommentableService.find_commentable(params)
    @comment = Comment.new( 
      parent_id: @parent_id, 
      commentable_id: @commentable.id,
      commentable_type: @commentable.class.to_s
    )
  end

  def edit
  end

  def update
    if stopped?(params[:current_bargain_id])
      flash[:error] = t 'bargain_was_stopped'
    else
      @current_comment.msg = params[:comment][:msg] 
      if @current_comment.save
        flash[:notice] = t 'successfully_created_comment'
      else
        flash[:error] = t 'error_adding_comment'
      end
    end
    redirect_to @current_comment.commentable
  end
  
  def create
    @commentable = FindCommentableService.find_commentable(params)
    @comment =
      @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.msg.empty?
      flash[:error] = t 'comment_is_empty'
      return redirect_to @commentable
    end
    if stopped?(params[:current_bargain_id])
      flash[:error] = t 'bargain_was_stopped'
      return redirect_to @commentable
    elsif @comment.ancestors.length > 2
      flash[:error] = t 'nesting_only_two_comments'
      return redirect_to @commentable
    elsif @comment.save
      flash[:notice] = t 'successfully_created_comment'
    else
      flash[:error] = t 'error_adding_comment'
    end
    redirect_to @commentable
  end

  def destroy
    @commentable =
      @current_comment.commentable
    if current_user.isadmin?
      @current_comment.destroy
      return redirect_to @commentable
    end

    if stopped?(params[:current_bargain_id])
      flash[:error] = t 'bargain_was_stopped'
    else 
      @current_comment.update_attribute(:user, nil)
      @current_comment.update_attribute(:msg, 'Comment was deleted')
    end
    redirect_to @commentable
  end
 
  private

  def stopped? bargain_id
    !CurrentBargain.find_by(id: bargain_id).lot.inprocess
  end
	
	def current_comment 
		@current_comment = Comment.find(params[:id])
	end

	def comment_params
  	params.require(:comment).permit(:msg, :user_id, :parent_id)
  end
end