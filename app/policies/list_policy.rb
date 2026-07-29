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
    record_owner?
  end

  def edit?
    record_owner?
  end

  def update?
    record_owner? && !record.default?
  end

  def destroy?
    record_owner? && !record.default?
  end

  private

  def record_owner?
    record.user == user
  end
end
