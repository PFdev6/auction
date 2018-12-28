class MessagesController < ApplicationController
  def destroy 
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to lots_path
  end
end
