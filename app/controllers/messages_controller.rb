class MessagesController < ApplicationController
  def destroy 
    @message = Message.includes(:current_bargain, :user).find(params[:id])
    @message.destroy
    redirect_to root_path
  end
end
