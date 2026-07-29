class User < ApplicationRecord
  has_many :authors, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :lists, dependent: :destroy

  after_create :create_default_lists

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_default_lists
    List::DEFAULT_LIST_NAMES.each do |name|
      lists.create!(name: name, default: true)
    end
  end
end
