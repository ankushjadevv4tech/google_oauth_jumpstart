class CreateSymptoms < ActiveRecord::Migration[7.0]
  def change
    create_table :symptoms do |t|
      t.references :beverage_entry, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :severity, null: false
      t.integer :onset_time, null: false
      
      t.timestamps
    end
  end
end
