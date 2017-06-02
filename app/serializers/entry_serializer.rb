class EntrySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  belongs_to :logbook
  has_many :data_entries
end
