require_relative '../../lib/sidekiq_extentions/sidekiq_client_middleware'
require_relative '../../lib/sidekiq_extentions/sidekiq_server_middleware'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add SidekiqClientMiddleware
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add SidekiqServerMiddleware
  end
end