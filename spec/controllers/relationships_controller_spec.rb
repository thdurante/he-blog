require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user1) { create(:user) }

  let(:user2) { create(:user) }

  describe 'POST #create' do
    describe 'logged user' do
      before(:each) do
        sign_in user1
      end

      it 'creates a new relationship' do
        expect {
          post :create, params: { relationship: { followed_id: user2.to_param } }
        }.to change(Relationship, :count).by(1)
      end

      it 'creates a success flash message' do
        post :create, params: { relationship: { followed_id: user2.to_param } }
        expect(flash[:success]).not_to be_empty
      end

      it 'redirects to blog_user_path' do
        post :create, params: { relationship: { followed_id: user2.to_param } }
        expect(response).to redirect_to(blog_user_path(user2))
      end
    end

    describe 'visitor' do
      it 'does not create a new relationship' do
        expect {
          post :create, params: { relationship: { followed_id: user2.to_param } }
        }.to change(Relationship, :count).by(0)
      end

      it 'redirects to login' do
        post :create, params: { relationship: { followed_id: user2.to_param } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in user1
      user1.follow(user2)
    end

    describe 'logged user' do
      it 'destroys a relationship' do
        expect {
          delete :destroy, params: { id: user1.active_relationships.find_by(followed_id: user2.to_param) }
        }.to change(Relationship, :count).by(-1)
      end

      it 'creates a success flash message' do
        delete :destroy, params: { id: user1.active_relationships.find_by(followed_id: user2.to_param) }
        expect(flash[:success]).not_to be_empty
      end

      it 'redirects to blog_user_path' do
        delete :destroy, params: { id: user1.active_relationships.find_by(followed_id: user2.to_param) }
        expect(response).to redirect_to(blog_user_path(user2))
      end
    end

    describe 'visitor' do
      before(:each) do
        sign_out user1
      end

      it 'does not destroy any relationship' do
        expect {
          delete :destroy, params: { id: user1.active_relationships.find_by(followed_id: user2.to_param) }
        }.to change(Relationship, :count).by(0)
      end

      it 'redirects to login' do
        delete :destroy, params: { id: user1.active_relationships.find_by(followed_id: user2.to_param) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
