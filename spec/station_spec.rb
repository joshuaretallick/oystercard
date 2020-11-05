require 'station'

describe Station do
  subject(:station) {described_class.new("Bank", 1)}

  it "knows it name" do
    expect(station.name).to eq("Bank")
  end

  it "knows its zone" do
    expect(station.zone).to eq(1)
  end

end
