require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  let(:other_user) { create(:user) }

  before do |example|
    sign_in user unless example.metadata[:skip_before_hook]
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.to_param } }

    context 'logged user' do
      it 'returns a success response' do
        expect(response).to be_success
      end

      it 'renders \'edit\' template' do
        expect(subject).to render_template(:edit)
      end

      it 'renders the \'application\' layout' do
        expect(subject).to render_template(layout: 'application')
      end
    end

    context 'visitor', :skip_before_hook do
      it 'redirects to sign_in page' do
        expect(subject).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name:                  'New name',
          password:              'password12345',
          password_confirmation: 'password12345',
        }
      end

      it 'updates the requested user' do
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.name).to eq('New name')
      end

      it 'redirects to the root_path' do
        put :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '' }
      end

      it 'assigns the user as @user' do
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it 're-renders the \'edit\' template' do
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to render_template(:edit)
      end

      it 'creates an error flash message' do
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(flash[:error].count).not_to eq(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to user_sign_up_path' do
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to new_user_registration_path
    end
  end

  describe 'GET #following' do
    before(:each) do
      user.follow(other_user)
      get :following, params: { id: user.to_param }
    end

    it 'renders \'following\' template' do
      expect(subject).to render_template(:following)
    end

    it 'renders the \'application\' layout' do
      expect(subject).to render_template(layout: 'application')
    end

    it 'assigns user as @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns following as @following' do
      expect(assigns(:following)).to eq([other_user])
    end
  end

  describe 'GET #followers' do
    before(:each) do
      sign_out user
      sign_in other_user
      other_user.follow(user)
      get :followers, params: { id: user.to_param }
    end

    it 'renders \'followers\' template' do
      expect(subject).to render_template(:followers)
    end

    it 'renders the \'application\' layout' do
      expect(subject).to render_template(layout: 'application')
    end

    it 'assigns user as @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns following as @following' do
      expect(assigns(:followers)).to eq([other_user])
    end
  end
end
