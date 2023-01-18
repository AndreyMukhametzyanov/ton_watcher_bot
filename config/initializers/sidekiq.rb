require_relative '../../lib/sidekiq_extentions/sidekiq_client_middleware'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add SidekiqClientMiddleware
  end
end