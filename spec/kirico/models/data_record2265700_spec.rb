# frozen_string_literal: true

# 賞与支払届データレコード
require 'spec_helper'

describe Kirico::DataRecord2265700, type: :model do
  describe 'regsitered valid factory' do
    subject { FactoryBot.build(:data_record2265700).valid? }
    it { is_expected.to be_truthy }
  end
  describe '#bonus_total' do
    let(:rec) { FactoryBot.build(:data_record2265700) }
    subject { rec.bonus_total(currency, goods) }
    context 'when currency & goods are both nil' do
      let(:currency) { nil }
      let(:goods) { nil }
      it { is_expected.to eq 0 }
    end
    context 'when currency is nil' do
      let(:currency) { nil }
      let(:goods) { 10_000 }
      it { is_expected.to eq 10_000 }
    end
    context 'when goods is nil' do
      let(:currency) { 20_000 }
      let(:goods) { nil }
      it { is_expected.to eq 20_000 }
    end
    context 'when both exists' do
      let(:currency) { 20_000 }
      let(:goods) { 10_000 }
      it { is_expected.to eq 30_000 }
    end
    context 'when the total has less thousand' do
      let(:currency) { 10_200 }
      let(:goods) { 10_200 }
      it { is_expected.to eq 20_000 }
    end
    context 'when the total is 9,999,999' do
      let(:currency) { 9_999_999 }
      let(:goods) { 0 }
      it { is_expected.to eq 9_999_000 }
    end
    context 'when the total is 10,000,000' do
      let(:currency) { 9_999_999 }
      let(:goods) { 1 }
      it { is_expected.to eq 9_999_999 }
    end
  end

  describe '#to_csv' do
    subject { FactoryBot.build(:data_record2265700).to_csv.encode('UTF-8') }
    it {
      is_expected.to eq '2265700,21,14,ｸﾄﾜ,000002,ﾖｼﾀﾞ ﾀﾛｳ,吉田　太郎,5,590527,9,010901,' \
        '444444,555555,999000,012345678901,0123,123456,,,,'
    }
  end
end
