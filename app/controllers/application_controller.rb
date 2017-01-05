class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?, :access_write_project, :access_read_project, :marketer?
  include AppConstants

  def admin?
    if current_user && current_user.role.name == ADMIN
      true
    else
      false
    end
  end
  
  def marketer?
    if current_user && current_user.role.name == Marketing
      true
    else
      false
    end
  end

  def access_write_project(project_id)
    user_project = UserProject.find_by_user_id_and_project_id(current_user.id, project_id)
    if user_project.present? && user_project.access_status == WRITE
      true
    else
      false
    end
  end

  def access_read_project(project_id)
    user_project = UserProject.find_by_user_id_and_project_id(current_user.id, project_id)
    if user_project.present? && user_project.access_status == READ
      true
    else
      false
    end
  end

  def check_authorize_user
    if admin? || marketer?
    else
      flash[:danger] = 'You are not authorize to access this page'
      redirect_to root_url
    end
  end
end
