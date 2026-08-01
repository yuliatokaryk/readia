class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :user
  has_many :list_books, dependent: :destroy
  has_many :lists, through: :list_books
  has_many :reviews, dependent: :destroy
  has_one_attached :cover
end
