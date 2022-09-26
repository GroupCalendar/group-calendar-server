class DashboardController < ApplicationController

  def index
    @groups = current_user.groups
    @events = current_user.events
  end
end
