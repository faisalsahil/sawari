class CategoriesController < ApplicationController
  before_action :check_authorize_user
  
  def create
    project = Project.find_by_id(params[:project_id])
    category = project.categories.build(category_params)
    if category.save
      flash[:success] = "Category successfully created"
      redirect_to project_path(project)
    else
      flash[:danger] = "Category name can't blank"
      redirect_to :back
    end
  end

  def edit
    @category = Category.find_by_id(params[:id])
    @project  = @category.project
  end


  def update
    @category = Category.find_by_id(params[:id])
    @category.update_attributes(category_params)
    @project  = @category.project

    flash[:success] = "Category successfully updated"
    redirect_to project_path(@project)
  end

  def destroy
    category = Category.find_by_id(params[:id])
    if category.present? && category.is_deleted == false
      category.is_deleted = true
      flash[:success] = "Category successfully deleted"
    else
      category.is_deleted = false
      flash[:success] = "Category successfully activated"
    end
    category.save!
    redirect_to project_path(params[:project_id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
