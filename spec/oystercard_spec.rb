

require 'oystercard'


describe Oystercard do
subject(:oystercard) {described_class.new}
let (:topped_up_oystercard) {described_class.new(5)}


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
          expect{subject.deduct 30}.to change{subject.balance}.by (-30)
        end
      end

         it 'passenger starts not in journey' do
         expect(subject).not_to be_in_journey
       end


      describe "#touch_out" do
        it 'passenger can touch out' do
          topped_up_oystercard.touch_in
          topped_up_oystercard.touch_out
          expect(topped_up_oystercard).not_to be_in_journey
        end
      end

      describe "#touch_in" do
          it 'passenger can touch in' do
            topped_up_oystercard.touch_in
            expect(topped_up_oystercard).to be_in_journey

          it 'deducts travel fare upon touch_in' do
            fare = Oystercard::FARE
            expect{topped_up_oystercard.touch_in}.to change {topped_up_oystercard.balance}.by (-fare)

          end
        end

          it 'raises an error if minimum balance not reached' do
            minimum_balance = Oystercard::MINIMUM_BALANCE
            expect{subject.touch_in}.to raise_error "Minimum balance of #{minimum_balance} not reached"
          end
        end





end
