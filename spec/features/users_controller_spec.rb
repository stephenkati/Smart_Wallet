require 'rails_helper'

RSpec.describe 'splash page', type: :feature do
  context 'when users is not logged in' do
    it 'displays app name' do
      visit unauthenticated_root_path

      expect(page).to have_content('Smart Wallet')
    end
  end
end
