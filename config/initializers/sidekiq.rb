# frozen_string_literal: true

# config/initializers/sidekiq.rb
redis_url = if Rails.env.development? || Rails.env.test?
              ENV.fetch('REDIS_URL', 'redis://localhost:6379/1')
            else
              ENV.fetch('REDIS_URL', 'redis://redis:6379/1')
            end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end