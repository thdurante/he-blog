require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HeBlog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = 'pt-BR'

    # Amazon S3 settings for Paperclip uploads
    config.paperclip_defaults = {
        storage: :s3,
        s3_protocol: 'https',
        url: ':s3_domain_url',
        path: '/:class/:attachment/:id_partition/:style/:filename',
        s3_credentials: {
            bucket: ENV.fetch('S3_BUCKET_NAME'),
            access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
            secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
            s3_region: ENV.fetch('AWS_REGION'),
        }
    }
  end
end
