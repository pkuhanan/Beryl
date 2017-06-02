class DataEntry < ApplicationRecord
  belongs_to :entry
  belongs_to :column
  delegate :logbook, :to => :entry
  delegate :user, :to => :entry
  
  validates :data, :presence => true
  validates :column, inclusion: { in: lambda {|record| record.logbook.columns},
    message: "%{value} is not a valid column for this logbook" } 
  
end
