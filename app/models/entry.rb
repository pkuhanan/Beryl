class Entry < ApplicationRecord
  belongs_to :logbook
  has_many :data_entries
end
