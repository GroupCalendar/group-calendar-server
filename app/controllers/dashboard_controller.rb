class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
    @events = current_user.events
    @todays_events = @events.select { |event| event.start_time > DateTime.now }
  end
end
