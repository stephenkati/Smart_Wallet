require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  describe 'GET #new' do
    it 'assigns a new item' do
      Category.create(name: 'my category', icon: 'icon', user_id: 1)
      get new_category_item_path(category)

      expect(assigns(:item)).to be_a_new(Item)
    end

    it 'renders the new template' do
      Category.create(name: 'my category', icon: 'icon', user_id: 1)
      get new_category_item_path(category)

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new item' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        expect do
          post category_items_path(category), params: { item: { name: 'Item', amount: 10 } }
        end.to change(Item, :count).by(1)
      end

      it 'sets the flash notice' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        post category_items_path(category), params: { item: { name: 'Item', amount: 10 } }

        expect(flash[:notice]).to eq('Item created successfully')
      end

      it 'redirects to the category page' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        post category_items_path(category), params: { item: { name: 'Item', amount: 10 } }

        expect(response).to redirect_to(category_path(category))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new item' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        expect do
          post category_items_path(category), params: { item: { name: '', amount: 10 } }
        end.not_to change(Item, :count)
      end

      it 'sets the flash notice' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        post category_items_path(category), params: { item: { name: '', amount: 10 } }

        expect(flash[:notice]).to eq('Failed to create Item!')
      end

      it 'renders the new template' do
        Category.create(name: 'my category', icon: 'icon', user_id: 1)
        user = User.create(name: 'John', email: 'user@example.com', password: 'password')
        sign_in(user)

        post category_items_path(category), params: { item: { name: '', amount: 10 } }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the item' do
      Category.create(name: 'my category', icon: 'icon', user_id: 1)
      item = Item.create(name: 'Item', amount: 10, author_id: 1)

      expect do
        delete item_path(item)
      end.to change(Item, :count).by(-1)
    end

    it 'sets the flash notice' do
      Category.create(name: 'my category', icon: 'icon', user_id: 1)
      item = Item.create(name: 'Item', amount: 10, author_id: 1)

      delete item_path(item)

      expect(flash[:notice]).to eq('Item deleted successfully')
    end

    it 'redirects to the category page' do
      Category.create(name: 'my category', icon: 'icon', user_id: 1)
      item = Item.create(name: 'Item', amount: 10, author_id: 1)

      delete item_path(item)

      expect(response).to redirect_to(category_path(category))
    end
  end
end
