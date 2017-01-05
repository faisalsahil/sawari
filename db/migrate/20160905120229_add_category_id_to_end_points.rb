class AddCategoryIdToEndPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :end_points, :category_id, :integer
  end
end
