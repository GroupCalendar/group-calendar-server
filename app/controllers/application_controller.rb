class ApplicationController < ActionController::Base
  include Authentication

  def is_current_controller(names)
    names.include?(current_controller)
  end
end
