require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

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
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "can touch out" do
      oystercard.top_up(2)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it "throws an error when touch_in if balance < MINIMUM_FARE" do
      expect{ oystercard.touch_in }.to raise_error "Insufficient Funds!"
    end

    it "deducts fare amount when user touches out" do
      oystercard.top_up(2)
      oystercard.touch_in
      expect{ oystercard.touch_out }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end

  end

end
