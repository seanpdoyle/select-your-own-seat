class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :floor, null: false, foreign_key: true
      t.integer :price, null: false

      t.timestamps
    end
    add_index :sections, :slug
  end
end
