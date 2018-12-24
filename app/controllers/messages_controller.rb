class MessagesController < ApplicationController
  def destroy 
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to request.path, success: t('complete')
  end
end
