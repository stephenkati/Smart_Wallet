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
    it 'displays the user name' do
      expect(page).to have_content("Hi #{user.name.split.first}")
    end

    it 'displays the sign out button' do
      expect(page).to have_button('Sign out')
    end

    it 'displays the "Add Category" link' do
      expect(page).to have_link('Add Category', href: new_category_path)
    end

    it 'displays the category details' do
      visit new_category_path
      fill_in 'category_name', with: category.name
      fill_in 'category_icon', with: category.icon
      click_button 'Save'
      visit categories_path

      expect(page).to have_content(category.name)
      expect(page).to have_content(category.icon)
      expect(page).to have_content(category.total_amount)
    end
  end

  context 'show page' do
    it 'displays the category details' do
      category.items << item

      visit category_path(category)

      expect(page).to have_content(category.name)
      expect(page).to have_link('Edit', href: edit_category_path(category))
      expect(page).to have_button('Delete', type: 'submit')

      expect(page).to have_content(item.name)
      expect(page).to have_content(item.amount)

      expect(page).to have_link('Edit', href: edit_category_item_path(category, item))
      expect(page).to have_button('Delete', type: 'submit')
    end

    it 'show page displays the "Add Transaction" link' do
      visit category_path(category)

      expect(page).to have_link('Add Transaction', href: new_category_item_path(category))
    end

    it 'show page displays the back link to categories index' do
      visit category_path(category)

      expect(page).to have_link('<< Back', href: categories_path)
    end
  end
end
