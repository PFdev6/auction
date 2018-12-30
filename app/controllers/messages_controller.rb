class MessagesController < ApplicationController
  def destroy 
    @message = Message.includes(:current_bargain, :user).find(params[:id])
    @message.destroy
    redirect_to root_path
  end

  def update
    @message = Message.find(params[:id])
    user = @message.current_bargain.user
    user.update_attributes(likes: user.likes+1)
    @message.destroy
		redirect_to @message.current_bargain.user
  end
end
