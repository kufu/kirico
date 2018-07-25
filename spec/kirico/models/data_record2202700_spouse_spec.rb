# frozen_string_literal: true

require 'spec_helper'

describe Kirico::DataRecord2202700Spouse, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryGirl.build(:data_record2202700_spouse).valid? }
    # it {
    #   rec = FactoryGirl.build(:data_record2202700_spouse)
    #   rec.valid?
    #   binding.pry
    # }
    it { is_expected.to be_truthy }
  end
  describe '#to_csv' do
    subject { FactoryGirl.build(:data_record2202700_spouse).to_csv.encode('UTF-8') }
    it { is_expected.to eq '7,300710,ﾀﾅｶ ﾅｵ,田中　菜緒,5,570619,2,000000000000,8484,808240,外国籍の場合,ｶﾞｲｺｸｼﾞﾝ ﾂｳｼｮｳ,外国人　通称,2,,739,1742,広島県広島市安佐北区亀崎,2,080,8383,83838,7,300701,1,,2,0900000,,,,,,,これが備考だ' }
  end
end
