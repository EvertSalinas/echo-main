class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  
  def pundit_user
    current_admin_user
  end
end
