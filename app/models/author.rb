class Author < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy
  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
