require 'rails_helper'

RSpec.describe Blog::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/blog/users/1').to route_to('blog/users#show', id: '1')
    end
  end
end
