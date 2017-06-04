class LogbookPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin? 
        scope
      else
        scope.where(:user => user).or(scope.where(:private => false))
      end
    end
  end
  
  def index?
    true
  end
  
  def permitted_attributes
    [:name, :description, :private]
  end
end