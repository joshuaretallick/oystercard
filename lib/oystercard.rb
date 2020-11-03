class Oystercard

  MAXIMUM_BALANCE = 90

  attr_accessor :in_journey
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    raise "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if money + @balance > MAXIMUM_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient Funds!" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
