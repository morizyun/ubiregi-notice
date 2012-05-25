class WelcomeController < ApplicationController
  def index
    @notices = Notice.open
  end
end
