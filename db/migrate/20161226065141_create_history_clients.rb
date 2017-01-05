class CreateHistoryClients < ActiveRecord::Migration[5.0]
  def change
    create_table :history_clients do |t|
      t.integer :email_history_id
      t.integer :client_id
      t.timestamps
    end
  end
end
