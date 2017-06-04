class ColumnPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end
  
  def destroy?
    user.admin?
  end
  
  def permitted_attributes
    [:name, :data_type, :multiple]
  end
end
