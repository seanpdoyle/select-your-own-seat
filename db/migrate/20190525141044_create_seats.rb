class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.references :section, null: false, foreign_key: true
      t.string :row, null: false
      t.string :number, null: false
      t.integer :x, null: false
      t.integer :y, null: false

      t.timestamps
    end
    add_index :seats, :row
    add_index :seats, :number
  end
end
