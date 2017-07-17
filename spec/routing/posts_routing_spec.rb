require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/posts').to route_to('posts#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/posts/1').to route_to('posts#destroy', id: '1')
    end
  end
end
