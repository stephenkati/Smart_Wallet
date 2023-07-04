require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let(:user) { User.create(name: "John Doe", email: "johndoe@example.com", password: "password") }
    let(:category) { Category.new(name: "Food", icon: "icon", user: user) }

    before do
      category.save
    end

    it 'should validate presence of name' do
      expect(category).to be_valid

      category.name = nil
      expect(category).to_not be_valid
    end

    it 'should validate presence of icon' do
      expect(category).to be_valid

      category.icon = nil
      expect(category).to_not be_valid
    end

    it 'should validate presence of user' do
      expect(category).to be_valid

      category.user = nil
      expect(category).to_not be_valid
    end
  end

  describe 'category associations' do
    it 'should be one to many payments' do
      expect(Category.reflect_on_association(:payments).macro).to eq(:has_many)
    end

    it 'should be one to many items' do
      expect(Category.reflect_on_association(:items).macro).to eq(:has_many)
    end

    it 'should be belongs to user' do
      expect(Category.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
  
end
