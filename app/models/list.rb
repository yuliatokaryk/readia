class List < ApplicationRecord
  DEFAULT_LIST_NAMES = [
    "Want to Read",
    "Currently Reading",
    "Read"
  ].freeze

  belongs_to :user
  has_many :list_books, dependent: :destroy
  has_many :books, through: :list_books
  validates :name, presence: true
end
