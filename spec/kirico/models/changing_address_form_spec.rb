# frozen_string_literal: true
require 'spec_helper'

describe Kirico::ChangingAddressForm do
  describe '#to_csv' do
    # http://qiita.com/fisherman08/items/84c0c380de96fa3ee591
    let(:table) { CSV.table('spec/fixtures/changing_address_SHFD0006.CSV', encoding: 'Shift_JIS:UTF-8', headers: false, converters: nil) }
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
      it { expect(table[6].join(',')).to eq '22187041,14,ｸﾄﾜ,000009,5116,825529,5,591018,739,1734,ﾋﾛｼﾏｹﾝﾋﾛｼﾏｼｱｻｷﾀｸ,広島県広島市安佐北区,7,290130,ﾋﾙﾀ ﾀﾛｳ,蛭田 太郎,ﾄｳｷｮｳﾄｼﾌﾞﾔｸｻｻﾂﾞｶ,東京都渋谷区笹塚1-59-1フォッフォ笹塚1007,' }
    end
  end
end
