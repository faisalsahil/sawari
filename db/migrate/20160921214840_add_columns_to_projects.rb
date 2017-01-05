class AddColumnsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_status, :string
    add_column :end_points, :is_active, :boolean
  end
end
