require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
        user_id: user.to_param,
        content: Faker::Lorem.paragraph
    }
  end

  let(:invalid_attributes) do
    {
        user_id: nil,
        content: ''
    }
  end

  before(:each) do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'assigns a newly created post as @post' do
        post :create, params: { post: valid_attributes }
        expect(assigns(:post)).to be_a(Post)
      end

      it 'redirects to blog_user_path' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(blog_user_path(controller.current_user))
      end

      it 'creates a success flash message' do
        post :create, params: { post: valid_attributes }
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved post as @post' do
        post :create, params: { post: invalid_attributes }
        expect(assigns(:post)).not_to be_persisted
      end

      it 'redirects to blog_user_path' do
        post :create, params: { post: invalid_attributes }
        expect(response).to redirect_to(blog_user_path(controller.current_user))
      end

      it 'creates an error flash message' do
        post :create, params: { post: invalid_attributes }
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post, user: user) }

    it 'destroys the requested post' do
      expect {
        delete :destroy, params: { id: post.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(blog_user_path(controller.current_user))
    end

    it 'creates a success flash message' do
      delete :destroy, params: { id: post.to_param }
      expect(flash[:success]).not_to be_nil
    end
  end
end
