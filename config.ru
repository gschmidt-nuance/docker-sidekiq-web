require 'sidekiq'
require 'sidekiq/web'

sidekiq_user = ENV.fetch('SIDEKIQ_USER') { 'admin' }
sidekiq_password = ENV.fetch('SIDEKIQ_PASSWORD') { 'admin' }

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: ENV['REDIS_NAMESPACE'] }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [sidekiq_user, sidekiq_password]
end

run Sidekiq::Web
