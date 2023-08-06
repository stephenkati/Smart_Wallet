require 'rails_helper'

RSpec.describe 'categories', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'user@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Category 1', icon: 'Icon', user_id: user.id) }
  let(:item) { Item.create(name: 'Item 1', amount: 100, author: user) }

  before(:each) do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit categories_path
  end

  context 'index page' do

    it 'displays the sign out button' do
      expect(page).to have_button('Sign out')
    end

    it 'displays the "Add Category" link' do
      expect(page).to have_link('Add Category', href: new_category_path)
    end
  end

  context 'show page' do
    it 'displays the category details' do
      category.items << item

      visit category_path(category)

      expect(page).to have_css('i.fa-pen-to-square')
      expect(page).to have_css('i.fa-trash')

      expect(page).to have_content(item.name)
      expect(page).to have_content(item.amount)

    end

    it 'show page displays the "Add Transaction" link' do
      visit category_path(category)

      expect(page).to have_link('Add Transaction', href: new_category_item_path(category))
    end
  end
end
