require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should belong_to :user }

  it { should belong_to(:recipient).class_name('User') }

  it { should belong_to(:notifiable) }

  let!(:user1) { create(:user) }

  let!(:user2) { create(:user) }

  let!(:notification1) { create(:notification, user: user1, notifiable: user2, recipient: user2) }

  let!(:notification2) { create(:notification, user: user2, notifiable: user1, recipient: user1) }

  it 'orders notifications by :created_at desc' do
    expect(described_class.all).to eq [notification2, notification1]
  end

  it 'queues sending notification for user' do
    expect {
      notification = create(:notification, user: user1, notifiable: user2, recipient: user2)
      notification.run_callbacks(:commit)
    }.to change(Notification, :count).by(1)
  end
end
