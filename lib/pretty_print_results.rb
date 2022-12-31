# frozen_string_literal: true

class PrettyPrintResults
  def self.print_result(hash)
    table = ''
    hash.each do |el|
      table += "Name: #{el['Name']}\nBalance: #{el['Balance']}💎\nPending Deposit: #{el['Pending Deposit']}💎\n" \
               "Pending Withdraw: #{el['Pending Withdraw']}💎\nWithdraw: #{el['Withdraw']}💎\n" \
               "*****************************\n"
    end
    table
  end
end
