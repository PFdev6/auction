require 'rails_helper'

RSpec.describe CheckService do
  let(:lot) { FactoryBot.create(:lot) }
  describe '.check_inprocces' do
    context 'Lot inprocess?' do 
      it 'it is should be false' do
        described_class.check_inprocces(lot, "0")
        expect(lot.inprocess?).to be_falsey  
      end
      it 'is is should be true' do
        described_class.check_inprocces(lot, "1")
        expect(lot.inprocess?).to be_truthy 
      end   
    end
  end
end 