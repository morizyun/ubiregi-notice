class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :basic_auth

  private

  def basic_auth
    return if Rails.env =~ /develop|test/
    authenticate_or_request_with_http_basic do |user,pass|
      user == (ENV['ADMIN_USER'] || 'admin') && pass == (ENV['ADMIN_PASS'] || 'p@ssword')
    end
  end
end
