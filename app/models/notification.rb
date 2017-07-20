class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  default_scope -> { order(created_at: :desc) }
  after_commit -> { NotificationRelayJob.perform_later(self) }
end
