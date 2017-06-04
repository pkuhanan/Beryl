class Entry < ApplicationRecord
  belongs_to :logbook
  has_many :data_entries
  delegate :user, :to => :logbook
  delegate :private?, :to => :logbook
end
