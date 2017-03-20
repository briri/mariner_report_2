require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.assets.enabled = true
    
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    config.assets.precompile += %w( helper.js )
    config.assets.precompile += %w(ckeditor/config.js)

    config.active_job.queue_adapter = :resque
    
    config.img_host_exclusions = [
      'https://pixel.wp.com',
      'facebook.'
    ]
  end
end
