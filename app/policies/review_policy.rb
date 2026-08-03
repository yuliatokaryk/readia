class ReviewPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :record

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user
        @scope.where("published = ? OR user_id = ?", true, @user.id)
      else
        @scope.where(published: true)
      end
    end
  end

  def create?
    user.present?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user == user
  end
end
