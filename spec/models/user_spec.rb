require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :email }

  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_uniqueness_of :username }

  it { should have_many(:posts).dependent(:destroy) }

  it { should have_attached_file(:avatar) }

  it do
    should validate_attachment_content_type(:avatar).
      allowing('image/png', 'image/gif').
      rejecting('text/plain', 'text/xml')
  end
end
