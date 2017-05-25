class CreateLogbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :logbooks do |t|
      t.string :name
      t.text :description
      t.boolean :private, :default => false
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
