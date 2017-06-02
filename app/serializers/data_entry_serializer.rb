class DataEntrySerializer < ActiveModel::Serializer
  attributes :id, :data, :created_at, :updated_at
  belongs_to :entry
  belongs_to :column
end
