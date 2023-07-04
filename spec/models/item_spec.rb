require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    let(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com', password: 'password') }
    let(:item) { Item.new(name: 'item', amount: 2, author: user) }

    before do
      item.save
    end

    it 'should validate presence of name' do
      expect(item).to be_valid
      item.name = nil

      expect(item).to_not be_valid
    end

    it 'should validate presence of amount' do
      expect(item).to be_valid
      item.amount = nil

      expect(item).to_not be_valid
    end

    it 'should validate presence of author_id' do
      expect(item).to be_valid
      item.author_id = nil

      expect(item).to_not be_valid
    end
  end

  describe 'item associations' do
    it 'should be one to many payments' do
      expect(Item.reflect_on_association(:payments).macro).to eq(:has_many)
    end

    it 'should be one to many categories' do
      expect(Item.reflect_on_association(:categories).macro).to eq(:has_many)
    end

    it 'should belong to author' do
      expect(Item.reflect_on_association(:author).macro).to eq(:belongs_to)
    end
  end
end
