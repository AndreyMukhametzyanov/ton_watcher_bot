require 'sidekiq-scheduler'

class AddSendDelayWorker
  include Sidekiq::Worker

  def perform
    logger.info 'AddSendDelayWorker task started'
    logger.info 'AddSendDelayWorker task finished'
  end
end
