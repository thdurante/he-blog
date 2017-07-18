require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { create(:user) }

  let(:user2) { create(:user) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :email }

  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_uniqueness_of :username }

  it { should have_many(:posts).dependent(:destroy) }

  it { should have_attached_file(:avatar) }

  it do
    should validate_attachment_content_type(:avatar)
      .allowing('image/png', 'image/gif')
      .rejecting('text/plain', 'text/xml')
  end

  it do
    should have_many(:active_relationships)
               .class_name('Relationship')
               .with_foreign_key(:follower_id)
               .dependent(:destroy)
  end

  it do
    should have_many(:passive_relationships)
               .class_name('Relationship')
               .with_foreign_key(:followed_id)
               .dependent(:destroy)
  end

  it do
    should have_many(:following)
               .through(:active_relationships)
               .source(:followed)
  end

  it do
    should have_many(:followers)
               .through(:passive_relationships)
               .source(:follower)
  end

  describe '#follow' do
    describe 'user1 follows user2' do
      it 'should increment the \'followings\' of user1 by 1' do
        expect {
          user1.follow(user2)
        }.to change(user1.following, :count).by(1)
      end

      it 'should increment the \'followers\' of user2 by 1' do
        expect {
          user1.follow(user2)
        }.to change(user2.followers, :count).by(1)
      end
    end
  end

  describe '#unfollow' do
    describe 'user1 unfollows user2' do
      before(:each) { user1.follow(user2) }

      it 'should decrement the \'followings\' of user1 by -1' do
        expect {
          user1.unfollow(user2)
        }.to change(user1.following, :count).by(-1)
      end

      it 'should decrement the \'followers\' of user2 by -1' do
        expect {
          user1.unfollow(user2)
        }.to change(user2.followers, :count).by(-1)
      end
    end
  end

  describe '#following?' do
    describe 'user1 follows user2' do
      before(:each) { user1.follow(user2) }

      it 'user1.following?(user2) should be true' do
        expect(user1.following?(user2)).to be_truthy
      end

      it 'user2.following?(user1) should be false' do
        expect(user2.following?(user1)).to be_falsey
      end
    end
  end
end
