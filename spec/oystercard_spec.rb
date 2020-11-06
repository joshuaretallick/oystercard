require 'oystercard'


describe OysterCard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  #let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it "created an instance of OysterCard" do
    expect(subject).to be_an_instance_of OysterCard
  end

  it "initialized card has a balance of 0 by default" do
    expect(subject.balance).to eq 0
  end

  it "initialized card is not on a journey" do
    expect(subject.journey).to eq nil
  end

  it "initialized card has an empty journey history array" do
    expect(subject.journey_history).to be_empty
  end

  describe "#top_up" do
    it "allows the user to add money" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "raises an error if #top_up exceeded maximum" do
      subject.top_up(OysterCard::MAX_BALANCE)
      expect { subject.top_up(1) }. to raise_error "Maximum balance is £#{OysterCard::MAX_BALANCE}"
    end
  end

  describe "#deduct" do
    it "reduces the oyster card balance" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.balance).to eq 9
    end
  end

  describe "#touch_in" do
#    let(:station) { double :station }
    it "responds to #touch_in" do
      expect(subject).to respond_to :touch_in
    end
    it "stores/remembers the station at touch_in" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.journey.entry_station).to eq entry_station
    end
    it "when touch_in, the journey has started" do
      subject.top_up(OysterCard::MIN_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it "checks that there is the min amount needed" do
      subject.top_up(OysterCard::MIN_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect { subject.touch_in(entry_station) }.to raise_error(RuntimeError, "Not enough funds")
    end

  end

  describe "#touch_out" do
#    let(:station) { double :station }
    it "responds to #touch_out}" do
      expect(subject).to respond_to :touch_out
    end
    it "when touch_out, the journey will have ended" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end
    it "deducts the min amount from the card" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change {subject.balance}.by(-OysterCard::MIN_CHARGE)
    end
    it "stores a journey hash" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change { subject.journey_history.length }.by 1
      #subject.touch_out(exit_station)
      #expect(subject.journey_history).to include journey
    end
  end
end
