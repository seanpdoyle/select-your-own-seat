class CreateSeatSelections < ActiveRecord::Migration[6.0]
  def change
    create_table :seat_selections do |t|
      t.references :seat, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end

    add_index :seat_selections, [:seat_id, :cart_id], unique: true
  end
end
