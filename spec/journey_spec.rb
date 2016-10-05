require 'journey'
require 'station'
require 'oystercard'

describe Journey do

  let(:entry_station) {Station.new(name: "Mayfair", zone: "Zone 1")}
  let(:exit_station) {Station.new(name: "Kings Cross", zone: "Zone 2")}
  subject { described_class.new(entry_station) }

  it "should start a journey" do
    expect(subject).to be_in_journey
  end

  it "should end a journey" do
    subject.finish_journey(exit_station)
    expect(subject).not_to be_in_journey
  end

  describe "#calculate_fare" do
    it "calculates the fare" do
      subject.finish_journey(exit_station)
      expect(subject.calculate_fare).to eq Journey::MINIMUM_FARE
    end
  end
end
