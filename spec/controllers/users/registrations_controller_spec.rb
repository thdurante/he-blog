require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:valid_params) do
    {
      name:                  Faker::Name.name,
      email:                 Faker::Internet.email,
      username:              Faker::Internet.user_name,
      password:              'secret12345',
      password_confirmation: 'secret12345',
    }
  end

  let(:invalid_params) do
    {
      name:                  nil,
      email:                 nil,
      username:              nil,
      password:              'something',
      password_confirmation: 'something else',
    }
  end

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    subject { get :new, params: {} }

    it 'renders the devise \'new\' template' do
      expect(subject).to render_template('devise/registrations/new')
    end

    it 'renders the \'authentication\' layout' do
      expect(subject).to render_template(layout: 'authentication')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_params }
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, params: { user: valid_params }
        expect(assigns(:user)).to be_a(User)
      end

      it 'redirects to root_path' do
        post :create, params: { user: valid_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_params }
        }.to change(User, :count).by(0)
      end

      it 'assigns an invalid @user' do
        post :create, params: { user: invalid_params }
        expect(assigns(:user)).not_to be_valid
      end

      it 'does not persist the user' do
        post :create, params: { user: invalid_params }
        expect(assigns(:user)).not_to be_persisted
      end

      it 're-renders the \'new\' template' do
        post :create, params: { user: invalid_params }
        expect(response).to render_template(:new)
      end
    end
  end
end
