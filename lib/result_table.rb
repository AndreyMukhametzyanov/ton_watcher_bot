class ResultTable
  MAX = 18

  def print_table(result)
    names = []
    b_nums = []
    pd_nums = []
    pw_nums = []
    w_nums = []

    result.each do |el|
      names << el["Name"]
      b_nums << el["Balance"]
      pd_nums << el["Pending Deposit"]
      pw_nums << el["Pending Withdraw"]
      w_nums << el["Withdraw"]
    end

    table = "Name                           Bal.                Pending Dep           Pend.w-draw            W-draw\n"

    names.each_with_index do |el, i|
      table += get_line(names[i], b_nums[i], pd_nums[i], pw_nums[i], w_nums[i])
    end

    table
  end

  private

  def get_line(name, b_num, pd_num, pw_num, w_num)
    spaces = MAX * 1.61 - (b_num.to_s.size + name.size)
    spaces3 = MAX - (pd_num.to_s.size + pw_num.to_s.size)

    name + " " * spaces + b_num + " " * 3 + pd_num + " " * spaces3 + pw_num + " " * 10 + w_num + "\n"
  end
end
