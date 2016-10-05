require 'oystercard'

describe Oystercard do

    let(:station) {double :station}

    let(:entry_station) {double :entry_station}
    let(:exit_station)  {double :exit_station}

    let(:journey) {double :journey}

describe '#touch_in' do

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'stores journeys in a list' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.list_of_journeys).to eq [journey1, journey2]
  end

  it 'fines if touch in twice' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect{subject.touch_in(Station.new)}.to change{subject.balance}.by (-Oystercard::PENALTY_FARE)
    end

    it "won't touch in if below minimum balance" do
      expect{subject.touch_in(station)}.to raise_error 'Insufficient funds for jouney'
    end
end

describe '#touch_out' do

  before :each do
    subject.top_up(5)
    subject.touch_in(station)
  end

  it 'deducts correct fare' do
    expect { subject.touch_out(station) }.to change { subject.balance }.by (-Oystercard::MINIMUM_BALANCE)
  end

  it 'fines if touch out twice' do
     subject.top_up(10)
     expect{subject.touch_out(Station.new)}.to change{subject.balance}.by (-Oystercard::PENALTY_FARE)
  end

end

  describe '#top_up' do
    before :each do
      @balance = Oystercard::MAXIMUM_BALANCE
    end

    it 'will not add full amount if higher than max balance' do
      subject.top_up(@balance)
      expect{subject.top_up 5}.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

end
