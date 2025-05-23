class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      root_path
    end
  end
end