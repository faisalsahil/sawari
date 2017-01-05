class AddIsDeletedColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users,      :is_deleted, :boolean, default: false
    add_column :projects,   :is_deleted, :boolean, default: false
    add_column :categories, :is_deleted, :boolean, default: false
    add_column :end_points, :is_deleted, :boolean, default: false
  end
end
