require 'oystercard'


describe OysterCard do
  subject(:oystercard) { described_class.new }

      it "has a balance of zero" do
        expect(subject.balance).to eq 0
      end

      it "can be topped up with a value" do
      subject.top_up(20)
      expect(subject.balance).to eq 20
    end
end
