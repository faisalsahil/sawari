class AddColumnToUserProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_projects, :access_status
    add_column :user_projects, :access_status, :string
  end
end
