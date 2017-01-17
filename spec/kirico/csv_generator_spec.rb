# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CSVGenerator do
  describe '#to_csv' do
    let(:fd_management_record) { FactoryGirl.build(:fd_management_record) }
    let(:company) { FactoryGirl.build(:company) }
    let(:data) { FactoryGirl.build_list(:changing_address_record, 2) }
    let(:csv) { Kirico::CSVGenerator.new(fd_management_record, company, data).generate }
    let(:table) { CSV.parse(csv) }

    describe '1st row' do
      it { expect(table[0].join(',')).to eq '14,ｸﾄﾜ,005,20170117,22223' }
    end
    describe '2nd row' do
      it { expect(table[1].join(',')).to eq '[kanri]' }
    end
    describe '3rd row' do
      it { expect(table[2].join(',')).to eq ',001' }
    end
    describe '4th row' do
      it { expect(table[3].join(',')).to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,宮田昇始,03-5563-7662' }
    end
    describe '5th row' do
      it { expect(table[4].join(',')).to eq '[data]' }
    end
    describe '6th row' do
      it { expect(table[5].join(',')).to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中 太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
    end
    describe '7th row' do
      it { expect(table[6].join(',')).to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中 太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
    end
  end
end
