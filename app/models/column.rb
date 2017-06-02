class Column < ApplicationRecord
  has_many :data_entries
  has_and_belongs_to_many :logbooks, -> { distinct }
  
  validates :name, :data_type, presence: true
  validates :multiple, inclusion: { in: [ true, false ] }
  validates :name, uniqueness: { scope: [:data_type, :multiple]}
end
