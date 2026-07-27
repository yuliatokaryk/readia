class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :user
  belongs_to :list, optional: true
  has_one_attached :cover
end
