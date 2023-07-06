class Category < ApplicationRecord
  belongs_to :user

  has_many :payments, dependent: :destroy
  has_many :items, through: :payments

  validates :name, :icon, presence: true

  def total_amount
    items.sum(:amount)
  end
end
