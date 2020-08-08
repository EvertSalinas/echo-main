class ApplicationController < ActionController::Base
  def pundit_user
    current_admin_user
  end
end
