class LogbookSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :private, :created_at, :updated_at
  belongs_to :user 
  has_many :entries
  has_many :columns
end
