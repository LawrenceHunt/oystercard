require 'oystercard'

describe OysterCard do
  subject(:oystercard) { described_class.new }
      it "has a balance of zero" do
        expect(subject.balance).to eq 0
      end
end
