# frozen_string_literal: true

# 2018年3月以降 算定基礎届データレコード
require 'spec_helper'

describe Kirico::DataRecord2225700, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryBot.build(:data_record2225700).valid? }
    it { is_expected.to be_truthy }
  end

  describe 'over 70 valid factory' do
    subject { FactoryBot.build(:data_record2225700, ip_code: nil, seventy_years_and_over: 1).valid? }
    it { is_expected.to be_truthy }
  end

  describe 'no my_number over 70 valid factory' do
    subject { FactoryBot.build(:data_record2225700, ip_code: nil, my_number: nil, seventy_years_and_over: 1).valid? }
    it { is_expected.to be_truthy }
  end

  describe 'over 70 invalid factory' do
    subject {
      FactoryBot.build(
        :data_record2225700,
        ip_code: nil,
        my_number: nil,
        area_code_of_basic_pension_number: nil,
        serial_number_of_basic_pension_number: nil,
        seventy_years_and_over: 1
      ).valid?
    }
    it { is_expected.to be_falsey }
  end

  describe '#income_total' do
    let(:rec) { FactoryBot.build(:data_record2225700) }
    subject { rec.income_total(currency, goods) }
    context 'when currency & goods are both nil' do
      let(:currency) { nil }
      let(:goods) { nil }
      it { is_expected.to eq 0 }
    end
    context 'when currency is nil' do
      let(:currency) { nil }
      let(:goods) { 100 }
      it { is_expected.to eq 100 }
    end
    context 'when goods is nil' do
      let(:currency) { 200 }
      let(:goods) { nil }
      it { is_expected.to eq 200 }
    end
    context 'when both exists' do
      let(:currency) { 200 }
      let(:goods) { 100 }
      it { is_expected.to eq 300 }
    end
    context 'when the total is 9,999,999' do
      let(:currency) { 9_999_999 }
      let(:goods) { 0 }
      it { is_expected.to eq 9_999_999 }
    end
    context 'when the total is 10,000,000' do
      let(:currency) { 9_999_999 }
      let(:goods) { 1 }
      it { is_expected.to eq 9_999_999 }
    end
  end

  describe '#target_months' do
    let(:rec) {
      FactoryBot.build(
        :data_record2225700,
        ip_type: ip_type,
        apr_days: apr_days,
        may_days: may_days,
        jun_days: jun_days
      )
    }
    subject { rec.target_months }
    context 'when the person is ip_type_0' do
      let(:ip_type) { :ip_type_0 }
      context 'when all days are greather than or equal to 17' do
        let(:apr_days) { 17 }
        let(:may_days) { 17 }
        let(:jun_days) { 17 }
        it { is_expected.to match_array %i[apr may jun] }
      end
      context 'when some days are greather than or equal to 17' do
        let(:apr_days) { 17 }
        let(:may_days) { 16 }
        let(:jun_days) { 17 }
        it { is_expected.to match_array %i[apr jun] }
      end
      context 'when all days are less than 17' do
        let(:apr_days) { 16 }
        let(:may_days) { 16 }
        let(:jun_days) { 16 }
        it { is_expected.to match_array [] }
      end
    end
    context 'when the person is ip_type_1' do
      let(:ip_type) { :ip_type_1 }
      context 'when all days are greather than or equal to 17' do
        let(:apr_days) { 17 }
        let(:may_days) { 17 }
        let(:jun_days) { 17 }
        it { is_expected.to match_array %i[apr may jun] }
      end
      context 'when some days are greather than or equal to 17' do
        let(:apr_days) { 17 }
        let(:may_days) { 16 }
        let(:jun_days) { 17 }
        it { is_expected.to match_array %i[apr jun] }
      end
      context 'when all days are less than 17' do
        context 'when all days are greather than or equal to 15' do
          let(:apr_days) { 15 }
          let(:may_days) { 15 }
          let(:jun_days) { 15 }
          it { is_expected.to match_array %i[apr may jun] }
        end
        context 'when some days are greather than or equal to 15' do
          let(:apr_days) { 15 }
          let(:may_days) { 14 }
          let(:jun_days) { 15 }
          it { is_expected.to match_array %i[apr jun] }
        end
        context 'when all days are less than 15' do
          let(:apr_days) { 14 }
          let(:may_days) { 14 }
          let(:jun_days) { 14 }
          it { is_expected.to match_array [] }
        end
      end
    end
    context 'when the person is ip_type_2' do
      let(:ip_type) { :ip_type_2 }
      context 'when all days are greather than or equal to 11' do
        let(:apr_days) { 11 }
        let(:may_days) { 11 }
        let(:jun_days) { 11 }
        it { is_expected.to match_array %i[apr may jun] }
      end
      context 'when some days are greather than or equal to 11' do
        let(:apr_days) { 11 }
        let(:may_days) { 10 }
        let(:jun_days) { 11 }
        it { is_expected.to match_array %i[apr jun] }
      end
      context 'when all days are less than 11' do
        let(:apr_days) { 10 }
        let(:may_days) { 10 }
        let(:jun_days) { 10 }
        it { is_expected.to match_array [] }
      end
    end
  end

  describe '#income_all_total_with_round' do
    let(:rec) {
      FactoryBot.build(
        :data_record2225700,
        apr_income_currency: apr_income_currency,
        may_income_currency: may_income_currency,
        jun_income_currency: jun_income_currency,
        apr_income_goods: 0,
        may_income_goods: 0,
        jun_income_goods: 0
      )
    }
    subject { rec.income_all_total_with_round }
    before do
      allow(rec).to receive(:target_months).and_return(%i[apr may jun])
    end
    context 'when income_all_total is 9_999_999 or less' do
      let(:apr_income_currency) { 100 }
      let(:may_income_currency) { 200 }
      let(:jun_income_currency) { 300 }
      it { is_expected.to eq 600 }
    end
    context 'when income_all_total is more than 9_999_999' do
      let(:apr_income_currency) { 10_000_000 }
      let(:may_income_currency) { 0 }
      let(:jun_income_currency) { 0 }
      it { is_expected.to eq 9_999_999 }
    end
  end

  describe '#income_average' do
    let(:rec) {
      FactoryBot.build(
        :data_record2225700,
        apr_income_currency: apr_income_currency,
        may_income_currency: may_income_currency,
        jun_income_currency: jun_income_currency,
        apr_income_goods: 0,
        may_income_goods: 0,
        jun_income_goods: 0
      )
    }
    subject { rec.income_average }
    before do
      allow(rec).to receive(:target_months).and_return(target_months)
    end
    context 'when target_months is empty' do
      let(:target_months) { [] }
      let(:apr_income_currency) { 100 }
      let(:may_income_currency) { 100 }
      let(:jun_income_currency) { 100 }
      it { is_expected.to eq 0 }
    end
    context 'when target_months Apr & May' do
      let(:target_months) { %i[apr may] }
      let(:apr_income_currency) { 111 }
      let(:may_income_currency) { 222 }
      let(:jun_income_currency) { 999_999 }
      it { is_expected.to eq 166 }
    end
    context 'when avg is bigger than 9_999_999' do
      let(:target_months) { %i[apr may] }
      let(:apr_income_currency) { 10_000_000 }
      let(:may_income_currency) { 20_000_000 }
      let(:jun_income_currency) { nil }
      it { is_expected.to eq 9_999_999 }
    end
  end

  describe '#to_csv' do
    subject { FactoryBot.build(:data_record2225700).to_csv.encode('UTF-8') }
    it {
      is_expected.to eq '2225700,21,14,ｸﾄﾜ,000002,ﾖｼﾀﾞ ﾀﾛｳ,吉田　太郎,5,590527,7,28,09,' \
        '0410,0200,7,27,07,03,2,05,0000344,04,05,06,03,24,17,' \
        '0444444,0555555,0666666,0000444,0000555,0000666,0444888,0556110,0667332,' \
        '1223442,0611721,0001000,012345678901,0123,123456,,,,,,,,,,bikoooooo,'
    }
  end
end
