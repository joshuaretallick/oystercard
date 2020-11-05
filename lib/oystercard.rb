class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_accessor :in_journey, :trip_history
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @trip_history = []
  end

  def top_up(money)
    raise "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if money + @balance > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Insufficient Funds!" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(final_station)
    raise "You need to touch in first!" if !@entry_station
    @exit_station = final_station
    @trip_history << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(money)
    @balance -= money
  end

end
