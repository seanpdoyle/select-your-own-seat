class CreateFloors < ActiveRecord::Migration[6.0]
  def change
    create_table :floors do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
    add_index :floors, :slug
  end
end
