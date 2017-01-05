class ProjectsController < ApplicationController

  def index
    if admin?
      @projects = Project.all
    else
      @projects = current_user.projects.where(is_deleted: false)
    end
  end

  def create
    project = Project.new(project_params)
    if project.save
      redirect_to project_path(project)
    else
      flash[:danger] = 'Project not saved.'
      redirect_to :back
    end
  end

  def show
    if admin? || current_user.projects.find_by_id(params[:id]).present?
      @project    = Project.find_by_id(params[:id])
      @categories = @project.categories
    else
      flash[:danger] = 'You are not authorize to access this page'
      redirect_to projects_path
    end
  end

  def edit
    if admin? || access_write_project(params[:id])
      @project = Project.find_by_id(params[:id])
    else
      flash[:danger] = 'You are not authorize to access this page'
      redirect_to root_url
    end
  end

  def update
    @project = Project.find_by_id(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = 'Project successfully updated'
      redirect_to projects_path
    else
      flash[:danger] = @project.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    # authorize! :delete, @user
    @project = Project.find_by_id(params[:id])
    if @project.present? && @project.is_deleted == false
      @project.is_deleted = true
      flash[:success] = 'Project deleted.'
    else
      @project.is_deleted = false
      flash[:success] = 'Project activated.'
    end
    @project.save!
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
