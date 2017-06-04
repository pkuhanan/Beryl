class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :created_at, :updated_at
  has_many :logbooks, if: -> { scope.admin? || scope == object }
end
