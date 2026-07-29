class User < ApplicationRecord
  has_many :authors, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :lists, dependent: :destroy

  after_create :create_default_lists

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_default_lists
    lists.create!([
      { name: "Want to Read", default: true },
      { name: "Currently Reading", default: true },
      { name: "Read", default: true }
    ])
  end
end
