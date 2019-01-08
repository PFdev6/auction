class MessagesController < ApplicationController
  def destroy 
    @message = Message.includes(:current_bargain, :user).find(params[:id])
    @message.destroy
    render json: { success: true }
  end

  def update
    @message = Message.find_by(id: params[:id])
    if @message.present?
      user = @message.current_bargain.user
      user.update_attributes(likes: user.likes+1)
      @message.destroy
      return render json: { success: true, plike: true }
    end
    render json: { success: true, plike: false }
  end
end
