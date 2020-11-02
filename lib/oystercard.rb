class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if money + @balance > MAXIMUM_BALANCE
    @balance += money
  end

end

private

# def balance_exceeded?
#   money + @balance > MAXIMUM_BALANCE
# end
