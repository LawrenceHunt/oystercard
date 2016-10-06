require 'oystercard'
require 'journey'

describe Oystercard do

  let(:station) { double :station, name: "Knightsbridge", zone: 1 }
  let(:station2) { double :station, name: "Old Street", zone: 2 }
  let(:journey) { double :journey, entry_station: station, exit_station: station2 }

  describe "Initialization of a card" do

    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
    it 'sets journeys as empty at start' do
      expect(subject.journeys).to eq []
    end

  end



  context "When card has insufficient money" do
    it "should produce an error if you try to touch in." do
      expect{subject.touch_in station}.to raise_error ("Insufficient money on card for journey.")
    end
  end



  describe "#top_up" do
    it "can top up the balance" do
      expect {subject.top_up 10 }.to change{ subject.balance }.by 10
    end
  end

  context "When card is topped up" do
    before do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
    end

    it "fails if you try to exceed top-up limit" do
      expect{subject.top_up 1}.to raise_error "Top-up limit of £#{Oystercard::TOP_UP_LIMIT} exceeded."
    end



    describe "#touch_in" do

      it "should make 'in_journey' true" do
        subject.touch_in station
        expect(subject).to be_in_journey
      end
      it "should save the entry station" do
        subject.touch_in station
        expect(subject.journey.entry_station).to eq station
      end
      it 'should charge a fine when touching in twice' do
        subject.touch_in(station)
        expect{subject.touch_in(station2)}.to change{ subject.balance }.by (-Oystercard::PENALTY_FARE)
      end

    end



    describe "#touch_out" do

      it "should deduct £#{Oystercard::MINIMUM_FARE}" do
        subject.touch_in(station)
        expect{subject.touch_out station2}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end

      it "should make 'in_journey' false" do
        expect(subject).not_to be_in_journey
      end

      it "sets journey to nil" do
        expect(subject.journey).to be nil
      end

      it 'should charge a fine when touching out twice' do
        expect{subject.touch_out(station)}.to change{ subject.balance }.by (-Oystercard::PENALTY_FARE)
      end

      it 'records journey' do
        subject.touch_in(station)
        expect{subject.touch_out(station2)}.to change {subject.journeys.count}.by 1
      end
    end

  end
end
