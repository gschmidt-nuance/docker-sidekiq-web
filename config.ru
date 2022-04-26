require 'sidekiq'
require 'sidekiq/web'
require 'securerandom'; File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }

sidekiq_user = ENV.fetch('SIDEKIQ_USER') { 'admin' }
sidekiq_password = ENV.fetch('SIDEKIQ_PASSWORD') { 'admin' }

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: ENV['REDIS_NAMESPACE'] }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [sidekiq_user, sidekiq_password]
end

# now use the secret with a session cookie middleware
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

run Sidekiq::Web
