require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :content }

  let!(:user) { create(:user) }

  let!(:post1) { create(:post, user: user) }

  let!(:post2) { create(:post, user: user) }

  it 'orders posts by :created_at desc' do
    expect(described_class.all).to eq [post2, post1]
  end
end
