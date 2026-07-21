class AuthorPolicy < ApplicationPolicy
  attr_reader :user, :author

  def initialize(user, author)
    @user = user
    @author = author
  end

  def update?
    author.user == user
  end

  def destroy?
    author.user == user
  end
end
