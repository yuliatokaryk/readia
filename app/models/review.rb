class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :body, presence: true

  scope :published, -> { where(published: true) }
end
