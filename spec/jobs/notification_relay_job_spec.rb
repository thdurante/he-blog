require 'rails_helper'

RSpec.describe NotificationRelayJob, type: :job do
  let(:user1) { create(:user) }

  let(:user2) { create(:user) }

  let(:notification) { create(:notification, user: user1, recipient: user2, notifiable: user2, action: 'followed') }

  subject(:job) { notification }

  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test
    expect { subject }.to have_enqueued_job.on_queue('default')
  end
end
