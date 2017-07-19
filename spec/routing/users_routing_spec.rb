require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: '/users/1/edit').to route_to('users#edit', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/users/1').to route_to('users#destroy', id: '1')
    end

    it 'routes to #following' do
      expect(get: '/users/1/following').to route_to('users#following', id: '1')
    end

    it 'routes to #followers' do
      expect(get: '/users/1/followers').to route_to('users#followers', id: '1')
    end
  end
end
