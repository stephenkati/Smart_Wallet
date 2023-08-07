require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'payment associations' do
    it 'should be belongs to item' do
      expect(Payment.reflect_on_association(:item).macro).to eq(:belongs_to)
    end

    it 'should be belongs to category' do
      expect(Payment.reflect_on_association(:category).macro).to eq(:belongs_to)
    end
  end
end
