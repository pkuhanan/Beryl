class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :data_type, :multiple, :created_at, :updated_at
  has_many :data_entries
  has_many :logbooks
end
