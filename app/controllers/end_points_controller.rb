class EndPointsController < ApplicationController


  def new
    @methods = METHODS_TYPES
    @category = Category.find_by_id(params[:category_id])
    @end_point = @category.end_points.build
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @end_point = @category.end_points.build(set_params)
    @methods = METHODS_TYPES
    if @end_point.save
      flash[:success] = 'End Point save successfully.'
      redirect_to category_end_point_path(@category, @end_point)
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      @category = Category.find_by_id(params[:category_id])
      if admin? || access_read_project(@category.project.id) || access_write_project(@category.project.id)
        @end_point = @category.end_points.find_by_id(params[:id])
        format.html
        format.js { render layout: false }
      else
        flash[:danger] = 'You are not authorize to access this page'
        format.html {
          redirect_to root_url
        }
        format.js { render layout: false }

      end
    end

  end

  def edit
    @methods = METHODS_TYPES
    @category = Category.find_by_id(params[:category_id])
    if admin? || access_write_project(@category.project.id)
      @end_point = @category.end_points.find_by_id(params[:id])
    else
      flash[:danger] = 'You are not authorize to access this page'
      redirect_to root_url
    end

  end

  def update
    @end_point = EndPoint.find_by_id(params[:id])
    @category = @end_point.category
    @methods = METHODS_TYPES
    if @end_point.update_attributes(set_params)
      flash[:success] = 'Successfully saved.'
      redirect_to category_end_point_path(params[:category_id], @end_point)
    else
      render 'edit'
    end
  end

  def destroy
    # authorize! :delete, @user
    @end_point = EndPoint.find_by_id(params[:id])
    @end_point.destroy
    flash[:success] = 'Successfully deleted.'
    respond_to do |format|
      format.html { redirect_to project_path(project) }
      format.json { head :no_content }
    end
  end


  private
  def set_params
    params.require(:end_point).permit(:name, :url, :method, :request, :response, :notes)
  end

  def is_json?(json)
    begin
      return false unless json.is_a?(String)
      JSON.parse(json).all?
    rescue JSON::ParserError
      false
    end
  end
end
