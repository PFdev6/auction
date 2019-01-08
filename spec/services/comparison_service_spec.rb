require 'rails_helper'

RSpec.describe ComparisonService do
  let (:lot) { FactoryGirl.create(:lot) }
  let (:true_files) { %w(file1.img file2.img file3.img) }
  let (:false_files) { %w(file1.img file2.img file3.img file4.img) }
  let (:empty_files) { [] }

  describe '.check_file_count' do
    context 'When true files' do 
      it 'it is should be true' do
        result = described_class.check_file_count(true_files)
        expect(result).to be_truthy         
      end
    end

    context 'When false files' do 
      it 'it is should be false' do
        result = described_class.check_file_count(false_files)
        expect(result).to be_falsey     
      end
    end

    context 'When empty files' do 
      it 'it is should be false' do
        result = described_class.check_file_count(empty_files)
        expect(result).to be_falsey    
      end
    end
  end

  describe '.check_price?' do
    before do
      @lot_ap_l_sp = lot
      @lot_ap_l_sp = @lot_ap_l_sp.update_attributes(autopurchase_price: 100, start_price: 10)
    end
    context 'When start price less than autopurchase price' do 
      it 'it is should be true' do
        result = described_class.check_price?(lot)
        expect(result).to be_truthy   
      end
    end

    context 'When start price more than autopurchase price' do       
      it 'it is should be false' do
        result = described_class.check_price?(@lot_ap_l_sp)
        expect(result).to be_falsey    
      end
    end
  end

  describe '.check_time?' do
    context 'When lot_end_date more than  lot_end_date + 10min' do 
      it 'it is should be true' do
        result = described_class.check_time?(Time.now + 1000)
        expect(result).to be_truthy
      end
    end

    context 'When lot_end_date less than  lot_end_date + 10min' do 
      it 'it is should be false' do
        result = described_class.check_time?(Time.now + 300)
        expect(result).to be_falsey    
      end
    end

    context 'When lot_end_date is nil' do 
      it 'it is should be false' do
        result = described_class.check_time?(nil)
        expect(result).to be_falsey    
      end
    end
  end
end 