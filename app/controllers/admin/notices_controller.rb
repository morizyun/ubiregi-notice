class Admin::NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def new
    @notice = Notice.new
    @notice.close_at = Time.now + 1.month
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def create
    # TODO 指定しなくていいようにする
    @notice = Notice.new({close_at: close_at_to_date})

    if @notice.save
      redirect_to admin_notice_path(id: @notice.id)
    else
      render 'new'
    end
  end

  def update
    @notice = Notice.find(params[:id])

    if @notice.update_attributes(params[:admin_notice])
      redirect_to admin_notice_path(@notice)
    else
      render  'edit'
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy

    redirect_to admin_notices_url
  end

  private

  def close_at_to_date
    return nil unless params[:notice]['close_at(1i)']

    Time::local(params[:notice]['close_at(1i)'],
                params[:notice]['close_at(2i)'],
                params[:notice]['close_at(3i)'],
                params[:notice]['close_at(4i)'],
                params[:notice]['close_at(5i)'])
  end
end
