class MessagesController < ApplicationController
  def destroy 
    @message = Message.includes(:current_bargain, :user).find(params[:id])
    @message.destroy
    redirect_to root_path
  end

  def update
    @message = Message.find_by(id: params[:id])
    if @message.present?
      user = @message.current_bargain.user
      user.update_attributes(likes: user.likes+1)
      @message.destroy
  		return redirect_to user
    end
    redirect_to current_user
  end
end
