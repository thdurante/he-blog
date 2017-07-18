require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    subject { get :index }

    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    it 'renders \'index\' template' do
      expect(subject).to render_template(:index)
    end

    it 'renders the \'application\' layout' do
      expect(subject).to render_template(layout: 'application')
    end

    it 'assigns the user list as @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end
end
