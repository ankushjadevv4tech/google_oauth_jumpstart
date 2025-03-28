class CreateBeverageEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :beverage_entries do |t|
      t.datetime :consumed_at, null: false
      t.string :category, null: false
      t.string :subcategory
      t.decimal :quantity, null: false
      t.string :quantity_unit, null: false
      t.integer :temperature, null: false
      t.text :notes
      t.string :additions, array: true, default: []
      t.boolean :symptoms_occurred, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
