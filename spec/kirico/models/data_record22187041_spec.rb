# frozen_string_literal: true

require 'spec_helper'

describe Kirico::DataRecord22187041, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryGirl.build(:data_record22187041).valid? }
    it { is_expected.to be_truthy }
  end
  describe '#to_csv' do
    subject { FactoryGirl.build(:data_record22187041).to_csv.encode('UTF-8') }
    it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
  end
end
