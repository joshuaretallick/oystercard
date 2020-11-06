require_relative 'journey'

class OysterCard
MIN_CHARGE = 1
MIN_BALANCE = 1
MAX_BALANCE = 90
attr_reader :balance, :journey, :exit_station, :entry_station, :journey_history

  def initialize
    @balance = 0
    @journey = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey != nil
  end

  def touch_in(station)
    end_journey if @journey
    # if @journey != nil
    #   deduct(@journey.fare)
    # @journey_history << @journey
    # end
    raise "Not enough funds" if @balance < MIN_BALANCE
    @journey = Journey.new(station)

  end

  def touch_out(station)
    @journey = Journey.new(nil) if @journey == nil
    @journey.end(station)
    end_journey
  end

private
  def deduct(amount)
    @balance -= amount
  end

#DRY
  def end_journey
    deduct(@journey.fare)
    @journey_history << @journey
    @journey = nil
  end

end

#expect card to respond to touch_in, touch_out
#when touch_in, in_journey? returns true until touch_out
#when touch_out, in_journey? return false
