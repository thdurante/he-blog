class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_attached_file :avatar,
                    styles: { thumb: '160x160#' },
                    default_url: ActionController::Base.helpers.image_url('default-avatar.jpg')

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
