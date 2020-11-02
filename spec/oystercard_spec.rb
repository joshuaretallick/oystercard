require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "should return balance of 0 by default" do
    expect(oystercard.balance).to eq 0
  end

  it "should return a balance of 10 when top up 10" do
    expect{oystercard.top_up(10)}.to change{oystercard.balance}.by(10)
  end

end
