class User < ApplicationRecord
  has_many :authors, dependent: :destroy
  has_many :books, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
