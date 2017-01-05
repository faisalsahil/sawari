class SettingsController < ApplicationController

  # def index
  #   @projects = Project.all
  # end

  def projects
    # @setting = ProjectSetting.new
    @users    = User.all
    @projects = Project.all
  end


  # project_users create
  def create
    project_id = params[:project_id]
    if params[:read_user].present?
      params[:read_user].each do |user_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        if user_project.present?
          user_project.access_status = READ
          user_project.save!
        else
          UserProject.create!(user_id: user_id, project_id: project_id, access_status: READ)
        end
      end
    end

    if params[:write_user].present?
      params[:write_user].each do |user_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        if user_project.present?
          user_project.access_status = WRITE
          user_project.save!
        else
          UserProject.create!(user_id: user_id, project_id: project_id, access_status: WRITE)
        end
      end
    end

    users = Project.find_by_id(project_id).users
    if users.present?
      user_ids  = users.pluck(:id)
      user_ids  = user_ids.map(&:to_s)
      user_ids  = user_ids.reject { |h| params[:read_user].include? h }  if params[:read_user].present?
      user_ids  = user_ids.reject { |h| params[:write_user].include? h } if params[:write_user].present?

      user_ids && user_ids.each do |user_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        user_project.destroy if user_project.present?
      end
    end
    flash[:success] = 'Changes successfully submitted.'
    redirect_to projects_settings_path
  end


  def users
    @users    = User.all
    @projects = Project.all
  end


  # user_projects create
  def create_user_projects
    user_id = params[:user_id]
    if params[:read_project].present?
      params[:read_project].each do |project_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        if user_project.present?
          user_project.access_status = READ
          user_project.save!
        else
          UserProject.create!(user_id: user_id, project_id: project_id, access_status: READ)
        end
      end
    end

    if params[:write_project].present?
      params[:write_project].each do |project_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        if user_project.present?
          user_project.access_status = WRITE
          user_project.save!
        else
          UserProject.create!(user_id: user_id, project_id: project_id, access_status: WRITE)
        end
      end
    end

    projects = User.find_by_id(user_id).projects
    if projects.present?
      project_ids  = projects.pluck(:id)
      project_ids  = project_ids.map(&:to_s)
      project_ids  = project_ids.reject { |h| params[:read_project].include? h }  if params[:read_project].present?
      project_ids  = project_ids.reject { |h| params[:write_project].include? h } if params[:write_project].present?

      project_ids && project_ids.each do |project_id|
        user_project = UserProject.find_by_user_id_and_project_id(user_id, project_id)
        user_project.destroy if user_project.present?
      end
    end
    flash[:success] = 'Changes successfully submitted.'
    redirect_to users_settings_path
  end
end
