require "oystercard"
require "station"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:station) { double :station }
  let(:final_station) { double :final_station }

    it 'stores the entry station in entry_station instance variable' do
      oystercard.top_up(25)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

    it 'stores the exit station in exit_station instance variable' do
      oystercard.top_up(25)
      oystercard.touch_in(station)
      oystercard.touch_out(final_station)
      expect(oystercard.exit_station).to eq(final_station)
    end

  context "Testing the functionality of the card" do
    it "should return balance of £0 by default" do
      expect(oystercard.balance).to eq 0
    end

    it "should return a balance of £10 when top up £10" do
      expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by(10)
    end

    it "should throw an error when top_up takes balance over £90" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up(1) }.to raise_error "Maximum balance if £#{maximum_balance} exceeded"
    end

  end

  context "The user begins his/her journey" do
    it "is initially not in a journey" do
      expect(oystercard).not_to be_in_journey
    end

    it "can touch in" do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it "can touch out" do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      oystercard.touch_out(final_station)
      expect(oystercard).not_to be_in_journey
    end

    it "throws an error when touch_in if balance < MINIMUM_FARE" do
      expect{ oystercard.touch_in(station) }.to raise_error "Insufficient Funds!"
    end

    it "deducts fare amount when user touches out" do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      expect{ oystercard.touch_out(final_station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "raises an exception if user hasn't touched in but tries to touch out" do
      expect{ oystercard.touch_out(final_station) }.to raise_error "You need to touch in first!"
    end

    it "sets entry station to nil" do
      oystercard.top_up(25)
      oystercard.touch_in(station)
      oystercard.touch_out(final_station)
      expect(subject.entry_station).to eq nil
    end

    it "stores the journeys history as an instance variable" do
      expect(oystercard.trip_history).to be_empty
    end

    let(:trip_history) { { entry_station: station, exit_station: final_station} }

    it "stores the trip history" do
      oystercard.top_up(25)
      oystercard.touch_in(station)
      oystercard.touch_out(final_station)
      expect(oystercard.trip_history).to include trip_history
    end

  end

end
