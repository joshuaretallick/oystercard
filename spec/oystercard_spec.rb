require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "should return balance of 0 by default" do
    expect(oystercard.balance).to eq 0
  end

  it "should return a balance of 10 when top up 10" do
    expect{oystercard.top_up(10)}.to change{oystercard.balance}.by(10)
  end

  it "should throw an error when top_up takes balance over £90" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up(maximum_balance)
    expect{ oystercard.top_up 1 }.to raise_error "Maximum balance exceeded"
  end

end
