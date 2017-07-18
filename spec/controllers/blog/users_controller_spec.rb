require 'rails_helper'

RSpec.describe Blog::UsersController, type: :controller do
  let(:user) { create(:user) }

  before(:each) { sign_in user }

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.to_param }
      expect(response).to have_http_status(:success)
    end
  end
end
