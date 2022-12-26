class TelegramWebhooksController < Telegram::Bot::UpdatesController
  before_action :find_user

  include Telegram::Bot::UpdatesController::MessageContext
  #EQCi-oUQtQ4A-R625OCFQQvJj-8Ykh6j3rkwYjaL_-08hisv
  use_session!

  def start!(*)

    return if from['is_bot']

    if @current_user
      respond_with :message, text: 'Привет!'
      instructions
    else
      respond_with :message, text: "Для регистрации введите адресс Ton кошелька"
      save_context :add_ton_address
    end
  end

  def add_ton_address(address = nil, *)
    create_user!(address)
    respond_with :message, text: 'Привет! Вы зарегистрированы!'
    instructions
  end

  def instructions(*)
    respond_with :message, text: 'Выберите действие', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Узнать баланс', callback_data: 'get_result' },
          { text: 'Настройки отправки', callback_data: 'settings' }
        ]
      ]
    }
  end

  def set_settings(*)
    respond_with :message, text: 'Выберите интервал отправки', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Раз в день', callback_data: 'per_day' },
          { text: 'Раз в неделю', callback_data: 'per_week' },
          { text: 'Раз в месяц', callback_data: 'per_month' }
        ]
      ]
    }
  end

  def callback_query(data)
    case data
    when 'get_result'

      respond_with :message, text: "Подождите началась магия 🧙‍♂🪄"
      respond_with :message, text: "#{print_result(Parser.html_into_massive(@current_user.ton_address))}"
    when 'settings'
      set_settings
    when 'per_day'
      respond_with :message, text: "Выбрана рассылка раз в день"
      @current_user.update(send_period: 'day')
    when 'per_week'
      respond_with :message, text: "Выбрана рассылка раз в неделю"
      @current_user.update(send_period: 'week')
    when 'per_month'
      respond_with :message, text: "Выбрана рассылка раз в месяц"
      @current_user.update(send_period: 'month')
    else
      respond_with :message, text: "Куда полез??"
    end
  end

  private

  def print_result(result)
    table = ''
    result.each do |el|
      table += "Name: #{el["Name"]}\nBalance: #{el["Balance"]}💎\nPending Deposit: #{el["Pending Deposit"]}💎\nPending Withdraw: #{el["Pending Withdraw"]}💎\nWithdraw: #{el["Withdraw"]}💎\n*****************************\n"
    end
    table
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end

  def find_user
    @current_user = User.find_by(external_id: from['id'])
  end

  def create_user!(address)
    User.create!(
      external_id: from['id'],
      first_name: from['first_name'],
      last_name: from['last_name'],
      username: from['username'],
      language_code: from['language_code'],
      ton_address: address
    )
  end
end
