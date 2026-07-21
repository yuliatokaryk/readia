class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def update?
    book.user == user
  end

  def destroy?
    book.user == user
  end
end
