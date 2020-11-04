require 'station'

describe Station do
  subject(:station) {described_class.new}

  it "returns an instance of its own" do
    expect(subject).to be_instance_of(Station)
  end

end
