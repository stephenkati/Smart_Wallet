require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /splash' do
    it 'renders a successful response' do
      get unauthenticated_root_path
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get unauthenticated_root_path
      expect(response).to render_template('splash')
    end
  end
end
