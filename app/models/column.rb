class Column < ApplicationRecord
  has_many :data_entries
  has_and_belongs_to_many :logbooks
  
  validates :name, :data_type, presence: true
  validates :multiple, inclusion: { in: [ true, false ] }

end
