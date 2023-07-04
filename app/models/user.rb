class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, :email, :password, presence: true
end
