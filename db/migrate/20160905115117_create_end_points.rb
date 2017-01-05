class CreateEndPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :end_points do |t|
      t.string :name
      t.string :url
      t.string :method
      t.text :request
      t.text :response
      t.text :notes

      t.timestamps
    end
  end
end
