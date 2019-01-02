class CurrentBargainsController < ApplicationController
  before_action :cur_bargain, only: [:show]
  before_action :comments, :only => [:show]

  def index 
    @current_bargain = CurrentBargain
    .includes(:lot)
    .in_process
    .paginate(page: params[:page], per_page: 9)
    .order(created_at: :desc)
	end

  def show
  end

  def comments
    @commentable = find_commentable
    @comments = @commentable.comments.includes(:user).arrange(order: :created_at)
    @comment = Comment.new
  end

  def update
    bargain = request.parameters[:current_bargain]
    current_bargain = CurrentBargain.find(params[:current_bargain_id])
    if(current_bargain.lot.inprocess) 
      new_price = request.parameters[:current_bargain][:current_price].to_i
      result = UpdateCurrentBargain.call(
                                          params: [new_price: new_price, current_bargain_id: params[:current_bargain_id]],
                                          user: current_user
                                        )
      flash[:notice] = result.errors if result.errors
      redirect_to result.current_bargain 
    else
      flash[:notice] = 'Bargain was stopped'
      redirect_to bargain 
    end  
  end

  def edit
  end

  private

  def find_commentable
    return params[:controller].singularize.classify.constantize.find(params[:id])
  end

  def cur_bargain 
    @current_bargain = CurrentBargain.find(params[:id])
  end
  
  def current_bargain
		params.require(:current_bargain).permit(:user, :lot, :current_price)
  end

end
