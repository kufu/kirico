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
  describe 'validations' do
    describe 'living_together_type' do
      let(:rec) { FactoryGirl.build(:data_record2202700_spouse, change_type: change_type, living_together_type: living_together_type) }
      before { allow(rec).to receive(:assigned?).and_return(assigned) }
      subject { rec.valid? }
      context 'when spouse is NOT assigned' do
        let(:assigned) { false }
        context 'when change_type is :change_type_1' do
          let(:change_type) { :change_type_1 }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
        context 'when change_type is :change_type_2' do
          let(:change_type) { :change_type_2 }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
        context 'when change_type is :change_type_3' do
          let(:change_type) { :change_type_3 }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'when spouse is assigned' do
        let(:assigned) { true }
        context 'when change_type is :change_type_1' do
          let(:change_type) { :change_type_1 }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_falsy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
        context 'when change_type is :change_type_2' do
          let(:change_type) { :change_type_2 }
          before {
            rec.disqualified_at = Date.new(2018, 9, 9)
            rec.disqualified_reason_type = :disqualified_reason_type_1
            rec.death_at = Date.new(2018, 9, 10)
          }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
        context 'when change_type is :change_type_3' do
          let(:change_type) { :change_type_3 }
          context 'when living_together_type is nil' do
            let(:living_together_type) { nil }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_1' do
            let(:living_together_type) { :living_together_type_1 }
            it { is_expected.to be_truthy }
          end
          context 'when living_together_type is :living_together_type_2' do
            let(:living_together_type) { :living_together_type_2 }
            it { is_expected.to be_truthy }
          end
        end
      end
    end
    describe 'zip_code1' do
      let(:rec) { FactoryGirl.build(:data_record2202700_spouse, zip_code1: zip_code1) }
      before { allow(rec).to receive(:assigned?).and_return(assigned) }
      subject { rec.valid? }
      context 'when spouse is NOT assigned' do
        let(:assigned) { false }
        context 'when zip_code1 is nil' do
          let(:zip_code1) { nil }
          it { is_expected.to be_truthy }
        end
        context 'when zip_code1 is 714' do
          let(:zip_code1) { '714' }
          it { is_expected.to be_truthy }
        end
      end
      context 'when spouse is assigned' do
        let(:assigned) { true }
        context 'when zip_code1 is nil' do
          let(:zip_code1) { nil }
          it { is_expected.to be_falsy }
        end
        context 'when zip_code1 is 714' do
          let(:zip_code1) { '714' }
          it { is_expected.to be_truthy }
        end
      end
    end
    describe 'qualified_reason_etc' do
      let(:rec) { FactoryGirl.build(:data_record2202700_spouse, qualified_reason_type: qualified_reason_type, qualified_reason_etc: qualified_reason_etc) }
      subject { rec.valid? }
      context 'when qualified_reason_type is :qualified_reason_type_1' do
        let(:qualified_reason_type) { :qualified_reason_type_1 }
        context 'when qualified_reason_etc is nil' do
          let(:qualified_reason_etc) { nil }
          it { is_expected.to be_truthy }
        end
        context 'when qualified_reason_etc is set' do
          let(:qualified_reason_etc) { 'hoge' }
          it { is_expected.to be_truthy }
        end
      end
      context 'when qualified_reason_type is :qualified_reason_type_5' do
        let(:qualified_reason_type) { :qualified_reason_type_5 }
        context 'when qualified_reason_etc is nil' do
          let(:qualified_reason_etc) { nil }
          it { is_expected.to be_falsy }
        end
        context 'when qualified_reason_etc is set' do
          let(:qualified_reason_etc) { 'hoge' }
          it { is_expected.to be_truthy }
        end
      end
    end
  end
  describe '#to_csv' do
    subject { FactoryGirl.build(:data_record2202700_spouse).to_csv.encode('UTF-8') }
    it { is_expected.to eq '7,300710,ﾀﾅｶ ﾅｵ,田中　菜緒,5,570619,2,000000000000,8484,808240,外国籍の場合,ｶﾞｲｺｸｼﾞﾝ ﾂｳｼｮｳ,外国人　通称,2,,739,1742,広島県広島市安佐北区亀崎,2,080,8383,83838,7,300701,1,,2,0900000,,,,,,,これが備考だ' }
  end
end
