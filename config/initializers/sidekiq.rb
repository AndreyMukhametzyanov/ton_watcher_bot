require_relative '../../lib/sidekiq_extentions/sidekiq_server_middleware'

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add SidekiqServerMiddleware
  end
end