class NoticesController < ApplicationController
  before_filter :authorize, :only => [:create, :update, :close]

  def index
    now = params[:now] ? Time.parse(params[:now]) : Time.now
    locale = (params[:locale] || "").split
    render :json => { :notices => Notice.open(now).locale(locale).order("updated_at DESC") }, :locale => locale
  end

  def show
    render :json => { :notice => Notice.find(params[:id]) }
  end

  def create
    notice = Notice.create!(params[:notice])
    render :json => { :notice => notice }, :status => :created
  end

  def update
    notice = Notice.find(params[:id])
    notice.update_attributes(params[:notice])
    render :json => { :notice => notice }, :status => :ok
  end

  def close
    notice = Notice.find(params[:id])
    notice.close!
    render :json => { :notice => notice }
  end

  private

  def authorize
    secret = request.env['HTTP_X_UBIREGI_NOTICE_SECRET']
    unless secret == (ENV['UBIREGI_NOTICE_SECRET'] || "topsecret")
      render :status => :forbidden, :text => "Invalid secret"
    end
  end
end
