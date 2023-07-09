class Category < ApplicationRecord
  belongs_to :user

  has_many :payments, dependent: :destroy
  has_many :items, through: :payments

  validates :name, :icon, presence: true

  ICONS = {
    'fa-house' => 'Home',
    'fa-cart-shopping' => 'Shopping Cart',
    'fa-car' => 'Car',
    'fa-truck-medical' => 'Medical Truck',
    'fa-piggy-bank' => 'Piggy Bank',
    'fa-credit-card' => 'Credit Card'
  }.freeze 

  def total_amount
    items.sum(:amount)
  end
end
