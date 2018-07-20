# frozen_string_literal: true

require 'spec_helper'

describe Kirico::DataRecord2202700Dependent, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryGirl.build(:data_record2202700_dependent).valid? }
    it { is_expected.to be_truthy }
  end
  describe '#to_csv' do
    subject { FactoryGirl.build(:data_record2202700_dependent).to_csv.encode('UTF-8') }
    it { is_expected.to eq ',ﾀﾅｶ ﾀﾛｳ,田中 太郎,7,100808,1,02,,000000000000,1,7,300701,2,,0000333,1,,,,,,あああ' }
  end
end
