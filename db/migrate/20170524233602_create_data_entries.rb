class CreateDataEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :data_entries do |t|
      t.belongs_to :entry, foreign_key: true
      t.belongs_to :column, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
