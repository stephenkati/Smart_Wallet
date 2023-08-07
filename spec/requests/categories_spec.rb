require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  let(:user) { User.create(name: 'John Doe', email: 'user@example.com', password: 'password') }

  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password, name: user.name } }
    follow_redirect!
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      authenticate_user(user)
      get categories_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:category) { Category.create(name: 'my category', icon: 'icon', user_id: user.id) }

    it 'returns a successful response' do
      authenticate_user(user)
      get "/categories/#{category.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      authenticate_user(user)
      get '/categories/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:category_params) { { category: { name: 'my category', icon: 'icon' } } }

    it 'creates a new category' do
      authenticate_user(user)
      expect do
        post '/categories', params: category_params
      end.to change(Category, :count).by(1)
    end

    it 'redirects to the categories index' do
      authenticate_user(user)
      post '/categories', params: category_params
      expect(response).to redirect_to(categories_path)
    end
  end

  describe 'GET /edit' do
    let!(:category) { Category.create(name: 'my category', icon: 'icon', user_id: user.id) }

    it 'returns a successful response' do
      authenticate_user(user)
      get "/categories/#{category.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let!(:category) { Category.create(name: 'my category', icon: 'icon', user_id: user.id) }
    let(:updated_category_params) { { category: { name: 'updated category', icon: 'updated icon' } } }

    it 'updates the category' do
      authenticate_user(user)
      put "/categories/#{category.id}", params: updated_category_params
      category.reload
      expect(category.name).to eq('updated category')
      expect(category.icon).to eq('updated icon')
    end
  end

  describe 'DELETE /destroy' do
    let!(:category) { Category.create(name: 'my category', icon: 'icon', user_id: user.id) }

    it 'destroys the category' do
      authenticate_user(user)
      expect do
        delete "/categories/#{category.id}"
      end.to change(Category, :count).by(-1)
    end
  end
end
