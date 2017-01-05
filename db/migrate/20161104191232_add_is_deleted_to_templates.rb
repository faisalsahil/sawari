class AddIsDeletedToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :is_deleted, :boolean, default: false
  end
end
