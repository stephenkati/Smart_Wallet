require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:unknown) { User.new }
    let(:user) { User.new(name: 'John Doe', email: 'johndoe@example.com', password: 'password') }

    before do
      unknown.save
      user.save
    end

    it 'should validate presence of name' do
      expect(unknown).to_not be_valid
      expect(user).to be_valid
    end

    it 'should validate presence of email' do
      expect(unknown).to_not be_valid
      expect(user).to be_valid
    end

    it 'should validate presence of password' do
      expect(unknown).to_not be_valid
      expect(user).to be_valid
    end
  end

  describe 'user associations' do
    it 'should be one to many categories' do
      expect(User.reflect_on_association(:categories).macro).to eq(:has_many)
    end

    it 'should be one to many items' do
      expect(User.reflect_on_association(:items).macro).to eq(:has_many)
    end
  end
end
