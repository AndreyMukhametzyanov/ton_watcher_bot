# frozen_string_literal: true

require 'sidekiq-scheduler'

class AddSendDelayWorker
  include Sidekiq::Job
  sidekiq_options queue: 'delay'
  def perform(args)
    logger.info "AddSendDelayWorker#{args} task started"
    user = User.find_by(id: args)

    TelegramWebhooksController.send_message(
      text: PrettyPrintResults.print_result(WhalesPoolDataFetcher.html_into_massive(user.ton_address)),
      to: user.external_id
    )

    logger.info "AddSendDelayWorker#{args} task finished"
  end
end
