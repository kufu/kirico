# frozen_string_literal: true

# 月額変更届データレコード
require 'spec_helper'

describe Kirico::DataRecord2221700, type: :model do
  describe 'validation' do
    it { expect(FactoryBot.build(:data_record2221700)).to be_valid }

    describe '#each_month_days_should_be_greater_than_or_equal_11_or_17' do
      let(:record) { FactoryBot.build(:data_record2221700, short_time_worker: short_time_worker, before_1_month_days: days) }

      context '一般の被保険者の場合' do
        let(:short_time_worker) { nil }

        context '給与計算の基礎日数が10日の場合' do
          let(:days) { 10 }

          it { expect(record).not_to be_valid }
        end

        context '給与計算の基礎日数が11日の場合' do
          let(:days) { 11 }

          it { expect(record).not_to be_valid }
        end

        context '給与計算の基礎日数が17日の場合' do
          let(:days) { 17 }

          it { expect(record).to be_valid }
        end
      end

      context '短時間労働者の場合' do
        let(:short_time_worker) { 1 }

        context '給与計算の基礎日数が10日の場合' do
          let(:days) { 10 }

          it { expect(record).not_to be_valid }
        end

        context '給与計算の基礎日数が11日の場合' do
          let(:days) { 11 }

          it { expect(record).to be_valid }
        end

        context '給与計算の基礎日数が17日の場合' do
          let(:days) { 17 }

          it { expect(record).to be_valid }
        end
      end
    end

    describe '#seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number' do
      let(:record) do
        FactoryBot.build(
          :data_record2221700,
          seventy_years_and_over: seventy_years_and_over,
          my_number: my_number,
          area_code_of_basic_pension_number: area_code_of_basic_pension_number,
          serial_number_of_basic_pension_number: serial_number_of_basic_pension_number
        )
      end

      context '70歳以上被用者でない場合' do
        let(:seventy_years_and_over) { nil }

        context '個人番号のみ' do
          let(:my_number) { '803199283958' }
          let(:area_code_of_basic_pension_number) { nil }
          let(:serial_number_of_basic_pension_number) { nil }

          it { expect(record).to be_valid }
        end

        context '基礎年金番号のみ' do
          let(:my_number) { nil }
          let(:area_code_of_basic_pension_number) { '1234' }
          let(:serial_number_of_basic_pension_number) { '123456' }

          it { expect(record).to be_valid }
        end

        context 'どちらもない' do
          let(:my_number) { nil }
          let(:area_code_of_basic_pension_number) { nil }
          let(:serial_number_of_basic_pension_number) { nil }

          it { expect(record).to be_valid }
        end
      end

      context '70歳以上被用者である場合' do
        let(:seventy_years_and_over) { 1 }

        context '個人番号のみ' do
          let(:my_number) { '803199283958' }
          let(:area_code_of_basic_pension_number) { nil }
          let(:serial_number_of_basic_pension_number) { nil }

          it { expect(record).to be_valid }
        end

        context '基礎年金番号のみ' do
          let(:my_number) { nil }
          let(:area_code_of_basic_pension_number) { '1234' }
          let(:serial_number_of_basic_pension_number) { '123456' }

          it { expect(record).to be_valid }
        end

        context 'どちらもない' do
          let(:my_number) { nil }
          let(:area_code_of_basic_pension_number) { nil }
          let(:serial_number_of_basic_pension_number) { nil }

          it { expect(record).not_to be_valid }
        end
      end
    end
  end

  describe '#income_average' do
    it '１円未満は切捨てられる' do
      record = FactoryBot.build(
        :data_record2221700,
        before_3_month_income_currency: 33_333,
        before_2_month_income_currency: 33_333,
        before_1_month_income_currency: 33_334,
        before_3_month_income_goods: 0,
        before_2_month_income_goods: 0,
        before_1_month_income_goods: 0
      )

      expect(record.income_average).to eq 33_333
    end

    it '１千万円以上の実際の額にて平均額を算出する' do
      record = FactoryBot.build(
        :data_record2221700,
        before_3_month_income_currency: 15_000_000,
        before_2_month_income_currency: 0,
        before_1_month_income_currency: 0,
        before_3_month_income_goods: 0,
        before_2_month_income_goods: 0,
        before_1_month_income_goods: 0
      )

      expect(record.income_average).to eq 5_000_000
    end
  end

  describe '#to_csv' do
    subject { FactoryBot.build(:data_record2221700).to_csv.encode('UTF-8') }
    it {
      is_expected.to eq '2221700,21,57,ｹﾏ,17,ｺｳﾈﾝ ｻﾌﾞﾛｳ,厚年　三郎,5,350708,9,01,12,0260,0260,9,01,09,09,1,,,' \
        '09,10,11,31,30,31,300000,300000,300000,0,0,0,300000,300000,300000,900000,300000,' \
        ',,,,,,,基本給の変更,,,'
    }
  end
end
