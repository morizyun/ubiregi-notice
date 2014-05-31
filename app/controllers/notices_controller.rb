class NoticesController < ApplicationController
  skip_before_filter :basic_auth
  before_filter :authorize, :only => [:create, :update, :close]

  def index
    now = params[:now] ? Time.parse(params[:now]) : Time.now
    locale = (params[:locale] || 'en').split
    render :json => { :notices => Notice.open(now).locale(locale).order("updated_at DESC") }, :locale => locale
  end

  private

  def authorize
    secret = request.env['HTTP_X_UBIREGI_NOTICE_SECRET']
    unless secret == (ENV['UBIREGI_NOTICE_SECRET'] || "topsecret")
      render :status => :forbidden, :text => "Invalid secret"
    end
  end
end
