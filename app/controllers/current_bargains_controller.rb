class CurrentBargainsController < ApplicationController
  before_action :cur_bargain, only: [:edit, :update, :show]
  before_action :comments, :only => [:show]

  def index 
    @current_bargain = CurrentBargain.all.order(created_at: :desc)
	end

  def comments
    @commentable = find_commentable
    @comments = @commentable.comments.arrange(:order => :created_at)
    @comment = Comment.new
  end

  private
  def find_commentable
    return params[:controller].singularize.classify.constantize.find(params[:id])
  end

  def cur_bargain 
    @current_bargain  = CurrentBargain.find(params[:id])
  end
  
  def current_bargain
		params.require(:current_bargain).permit(:user, :lot, :current_price)
  end

end
