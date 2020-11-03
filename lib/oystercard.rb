class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_accessor :in_journey
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    raise "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if money + @balance > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Insufficient Funds!" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out
    raise "You need to touch in first!" if !@entry_station
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(money)
    @balance -= money
  end

end
