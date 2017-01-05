class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :email,  null: false, default: ""
      t.string :name
      t.string :phone
      
      
      t.timestamps
    end
    add_index :clients, :email,                unique: true
  end
end
