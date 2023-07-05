require 'rails_helper'

RSpec.describe 'User', type: :request do
  
  describe 'GET /index' do
    it 'renders a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template('index')
    end
  end

end
