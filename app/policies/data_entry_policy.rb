class DataEntryPolicy < ApplicationPolicy
  def permitted_attributes
    [:data]
  end
end