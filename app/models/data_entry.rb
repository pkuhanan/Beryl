class DataEntry < ApplicationRecord
  belongs_to :entry
  belongs_to :column
end
