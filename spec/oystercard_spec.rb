

require 'oystercard'


describe Oystercard do
subject(:oystercard) {described_class.new}

      it "has a balance of zero" do
        expect(subject.balance).to eq 0
      end

      describe '#top_up' do
            it "can be topped up with a value" do
            subject.top_up(20)
            expect(subject.balance).to eq 20
          end
        end

      it "raises an error if max balance exceeded" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} reached, you posho!"
      end

      describe '#deduct' do
        it 'deducts an amount' do
          subject.top_up 60
          expect{subject.deduct 30}.to change{subject.balance}.by -30
        end
      end

         it 'passenger starts not in journey' do
         expect(subject).not_to be_in_journey
       end
          it 'passenger can touch in' do
            subject.touch_in
          expect(subject).to be_in_journey
        end

        it 'passenger can touch out' do
          subject.touch_in
          subject.touch_out
          expect(subject).not_to be_in_journey
        end
end
