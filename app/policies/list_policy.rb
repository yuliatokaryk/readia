class ListPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
    scope.where(user: user)
    end

    private

    attr_reader :user, :scope
  end

  def show?
    record.user == user
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
