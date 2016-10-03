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
      it "raises an error if max balance exceeded" do
        maximum_balance = oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect(subject.top_up(1)).to raise_error "Maximum balance reached, you posho!"
      end
end
