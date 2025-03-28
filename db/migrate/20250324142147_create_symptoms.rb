class CreateSymptoms < ActiveRecord::Migration[7.0]
  def change
    create_table :symptoms do |t|
      t.references :beverage_entry, null: false, foreign_key: true
      t.string :name, array: true, default: []
      t.string :other_symptom
      t.integer :severity, null: false
      t.integer :onset_time, null: false
      
      t.timestamps
    end
  end
end
