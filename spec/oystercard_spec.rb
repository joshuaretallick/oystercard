require "oystercard"

describe Oystercard do

  it "should return balance of 0 by default" do
    expect(subject.balance).to eq 0
  end

  it "should return a balance of 10 when top up 10" do
    expect(subject.top_up(10)).to eq 10
  end

end
