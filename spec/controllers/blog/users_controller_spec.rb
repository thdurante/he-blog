require 'rails_helper'

RSpec.describe Blog::UsersController, type: :controller do
  let(:user1) { create(:user) }

  let(:user2) { create(:user) }

  before(:each) { sign_in user1 }

  describe 'GET #show' do
    subject { get :show, params: { id: user1.to_param } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders \'show\' template' do
      expect(subject).to render_template(:show)
    end

    it 'renders the \'application\' layout' do
      expect(subject).to render_template(layout: 'application')
    end

    it 'assigns user as @user' do
      get :show, params: { id: user1.to_param }
      expect(assigns(:user)).to eq(user1)
    end

    it 'assigns the user\'s posts as @posts' do
      get :show, params: { id: user1.to_param }
      expect(assigns(:posts)).to eq(user1.posts)
    end

    it 'assigns following user\'s posts as @recent_activity' do
      user1.follow(user2)
      get :show, params: { id: user1.to_param }
      expect(assigns(:recent_activity)).to eq(user2.posts)
    end
  end
end
