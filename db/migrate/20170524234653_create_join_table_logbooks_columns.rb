class CreateJoinTableLogbooksColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :columns_logbooks, id: false do |t|
      t.belongs_to :logbook, index: true
      t.belongs_to :column, index: true
    end
  end
end
