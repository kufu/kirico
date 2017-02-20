# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Form do
  let(:record) { FactoryGirl.build(:form) }

  describe '#to_csv' do
    let(:result) { record.to_csv.split("\n") }
    describe '1st line' do
      subject { result[0] }
      it { is_expected.to eq '14,ｸﾄﾜ,005,20170117,22223' }
    end
    describe '2nd line' do
      subject { result[1] }
      it { is_expected.to eq '[kanri]' }
    end
    describe '3rd line' do
      subject { result[2] }
      it { is_expected.to eq ',001' }
    end
    describe '4th line' do
      subject { result[3] }
      it { is_expected.to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,宮田昇始,03-5563-7662' }
    end
    describe '5th line' do
      subject { result[4] }
      it { is_expected.to eq '[data]' }
    end
    describe '6th line' do
      subject { result[5] }
      it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中 太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
    end
  end
end
