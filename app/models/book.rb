class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :user
  has_one_attached :cover
end
