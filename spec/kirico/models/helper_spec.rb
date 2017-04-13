# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Helper do
  describe '#define_format_date_method' do
    class HelperMock
      extend Kirico::Helper
      define_format_date_method :created_at
    end

    let(:obj) { HelperMock.new }

    describe '#fmt_ymd_created_at' do
      subject { obj.fmt_ymd_created_at }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq '19840723' }
      end
    end

    describe '#fmt_era_ymd_created_at' do
      subject { obj.fmt_era_ymd_created_at }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq '590723' }
      end
    end

    describe '#created_at_era_nengo' do
      subject { obj.created_at_era_nengo }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq 'S' }
      end
    end

    describe '#created_at_era_nengo_kanji' do
      subject { obj.created_at_era_nengo_kanji }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq '昭和' }
      end
    end

    describe '#created_at_era_year' do
      subject { obj.created_at_era_year }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq '59' }
      end
      context 'when created_at is 2017-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(2017, 7, 23)) }
        it { is_expected.to eq '29' }
      end
    end

    describe '#created_at_month' do
      subject { obj.created_at_month }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-01' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 1)) }
        it { is_expected.to eq '07' }
      end
    end

    describe '#created_at_day' do
      subject { obj.created_at_day }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-01' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 1)) }
        it { is_expected.to eq '01' }
      end
    end
  end

  describe '#define_code_mapper_method' do
    class HelperMock
      extend Kirico::Helper
      define_code_mapper_method :gender
    end

    let(:obj) { HelperMock.new }

    describe '#mapped_gender' do
      subject { obj.mapped_gender }

      context 'when gender is nil' do
        before { allow(obj).to receive(:gender).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when gender is 男性' do
        before { allow(obj).to receive(:gender).and_return('男性') }
        it { is_expected.to eq 0 }
      end
      context 'when gender is 女性' do
        before { allow(obj).to receive(:gender).and_return('女性') }
        it { is_expected.to eq 1 }
      end
      context 'when gender is 不明' do
        before { allow(obj).to receive(:gender).and_return('不明') }
        it { is_expected.to be_nil }
      end
    end
  end
end
