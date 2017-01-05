class AddColumnsToTemplates < ActiveRecord::Migration[5.0]
  def change
    remove_column :templates, :title
    add_column    :templates, :subject, :string
    add_column    :templates, :from,    :string
  end
end
