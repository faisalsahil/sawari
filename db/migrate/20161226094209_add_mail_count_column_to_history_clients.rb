class AddMailCountColumnToHistoryClients < ActiveRecord::Migration[5.0]
  def change
    add_column :history_clients, :count, :integer, default: 0
  end
end
