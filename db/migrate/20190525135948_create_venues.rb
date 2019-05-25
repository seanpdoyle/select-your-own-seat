class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :venues, :slug
  end
end
