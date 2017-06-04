class UserPolicy < ApplicationPolicy
  
  def index?
    true
  end
  
  def show?
    true
  end
  
  def create?
    true
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? || record == user
  end
  
  def permitted_attributes
    [:email, :name, :password]
  end
end