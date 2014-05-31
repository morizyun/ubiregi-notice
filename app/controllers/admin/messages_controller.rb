class Admin::MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def edit
    @message = Message.find(params[:id])
  end

  def new
    @notice = Notice.find(params[:notice_id])
    @message = @notice.messages.new
  end

  def create
    @notice = Notice.find(params[:notice_id])
    @message = @notice.messages.new(params[:message])

    if @message.save
      redirect_to admin_message_path(@message)
    else
      render 'new'
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to admin_message_path(@message)
    else
      render 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @notice = @message.notice
    @message.destroy

    redirect_to admin_notice_path(@notice)
  end
end
