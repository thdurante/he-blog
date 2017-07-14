require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    subject { get :new, params: {} }

    it 'renders the devise \'new\' template' do
      expect(subject).to render_template('devise/sessions/new')
    end

    it 'renders the \'authentication\' layout' do
      expect(subject).to render_template(layout: 'authentication')
    end
  end
end
