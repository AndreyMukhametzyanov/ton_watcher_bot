# frozen_string_literal: true

require 'sidekiq-scheduler'

class AddSendDelayWorker
  include Sidekiq::Job

  def perform(args)
    logger.info "AddSendDelayWorker#{args} task started"
    user = User.find_by(id: args)

    TelegramWebhooksController.send_message(
      text: print_result(Parser.html_into_massive(user.ton_address)),
      to: user.external_id
    )

    logger.info "AddSendDelayWorker#{args} task finished"
  end

  def print_result(result)
    table = ''
    result.each do |el|
      table += "Name: #{el['Name']}\nBalance: #{el['Balance']}💎\nPending Deposit: #{el['Pending Deposit']}💎\n" \
               "Pending Withdraw: #{el['Pending Withdraw']}💎\nWithdraw: #{el['Withdraw']}💎\n" \
               "*****************************\n"
    end
    table
  end
end
