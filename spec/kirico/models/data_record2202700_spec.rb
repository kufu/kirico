# frozen_string_literal: true

require 'spec_helper'

describe Kirico::DataRecord2202700, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryGirl.build(:data_record2202700).valid? }
    it { is_expected.to be_truthy }
  end
  describe '#to_csv' do
    subject { FactoryGirl.build(:data_record2202700).to_csv.encode('UTF-8') }
    let(:exptected_result) { '2202700,21,01,ｱｲｳ,0,7,300710,000003,ﾀﾅｶ ｹﾝｽｹ,田中 研介,5,590723,1,000000000000,1482,857028,3800000,,,,1,7,300710,ﾀﾅｶ ﾅｵ,田中 菜緒,5,570619,2,000000000000,8484,808240,外国籍の場合,ｶﾞｲｺｸｼﾞﾝ ﾂｳｼｮｳ,外国人 通称,2,,739,1742,広島県広島市安佐北区亀崎,2,080,8383,83838,7,300701,1,,2,0900000,,,,,,,これが備考だ,,,ﾀﾅｶ ﾀﾛｳ,田中 太郎,7,100808,1,02,,000000000000,1,7,300701,2,,0000333,1,,,,,,あああ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,' }

    it { is_expected.to eq exptected_result }
  end
end
