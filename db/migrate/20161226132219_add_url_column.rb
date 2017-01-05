class AddUrlColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :clients,  :url, :string
  end
end
