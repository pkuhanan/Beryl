class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :data_type, :multiple, :created_at, :updated_at
  has_many :data_entries, if: -> { scope.admin? }
  has_many :logbooks, if: -> { scope.admin? }
end
