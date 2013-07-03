class Api::MessagesController < ApplicationController
  respond_to :json
  def create
    if params[:channel_id]
      @channel = Channel.find_by(id: params[:channel_id])
    elsif params[:to]
      @channel = Channel.for_users(params[:to], message_params[:user_id])      
    end
    @message = @channel.messages.create(message_params)
    PrivatePub.publish_to "/messages/#{@channel.id}", {
      id: @message.id,
      author: @message.user.name,
      user_id: @message.user_id,
      body: @message.body,
      time: @message.created_at,
      channel_id: @channel.id
    }
  end

  def channel
    @channel = Channel.find(params[:channel_id])
    @messages = @channel.messages.includes(:user).order("created_at ASC")
  end
  
  def channel_for
    @to = User.find params[:to]
    @channel = Channel.for_users params[:to], params[:user_id]
  end
  
  private
    def message_params
      params.require(:message).permit(:channel, :user_id, :body)
    end
end
