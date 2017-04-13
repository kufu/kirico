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

  describe '#define_in_k_method' do
    class HelperMock
      extend Kirico::Helper
      define_in_k_method :currency
      define_in_k_method :currency_ceil, op: :ceil
      define_in_k_method :currency_floor, op: :floor
      define_in_k_method :currency_round, op: :round, precision: 2
    end

    subject { HelperMock.new }

    context 'w/o any arithmatic operation options' do
      context 'when currency is 10,499' do
        before { allow(subject).to receive(:currency).and_return(10_499) }

        describe '#currency_in_k' do
          it { expect(subject.currency_in_k).to eq('10') }
        end
      end

      context 'when currency is 10,500' do
        before { allow(subject).to receive(:currency).and_return(10_500) }

        describe '#currency_in_k' do
          it { expect(subject.currency_in_k).to eq('11') }
        end
      end

      context 'when currency is nil' do
        before { allow(subject).to receive(:currency).and_return(nil) }

        describe '#currency_in_k' do
          it { expect(subject.currency_in_k).to be_nil }
        end
      end
    end

    context 'w/ arithmatic operation option - ceil' do
      context 'when currency is 10,499' do
        before { allow(subject).to receive(:currency_ceil).and_return(10_499) }

        describe '#currency_ceil_in_k' do
          it { expect(subject.currency_ceil_in_k).to eq('11') }
        end
      end

      context 'when currency is 10,500' do
        before { allow(subject).to receive(:currency_ceil).and_return(10_500) }

        describe '#currency_ceil_in_k' do
          it { expect(subject.currency_ceil_in_k).to eq('11') }
        end
      end

      context 'when currency is nil' do
        before { allow(subject).to receive(:currency_ceil).and_return(nil) }

        describe '#currency_ceil_in_k' do
          it { expect(subject.currency_ceil_in_k).to be_nil }
        end
      end
    end

    context 'w/ arithmatic operation option - floor' do
      context 'when currency is 10,499' do
        before { allow(subject).to receive(:currency_floor).and_return(10_499) }

        describe '#currency_floor_in_k' do
          it { expect(subject.currency_floor_in_k).to eq('10') }
        end
      end

      context 'when currency is 10,500' do
        before { allow(subject).to receive(:currency_floor).and_return(10_500) }

        describe '#currency_floor_in_k' do
          it { expect(subject.currency_floor_in_k).to eq('10') }
        end
      end

      context 'when currency is nil' do
        before { allow(subject).to receive(:currency_floor).and_return(nil) }

        describe '#currency_floor_in_k' do
          it { expect(subject.currency_floor_in_k).to be_nil }
        end
      end
    end

    context 'w/ arithmatic operation option - round' do
      context 'when currency is 5,014' do
        before { allow(subject).to receive(:currency_round).and_return(5_014) }

        describe '#currency_round_in_k' do
          it { expect(subject.currency_round_in_k).to eq('5.01') }
        end
      end

      context 'when currency is 5,015' do
        before { allow(subject).to receive(:currency_round).and_return(5_015) }

        describe '#currency_round_in_k' do
          it { expect(subject.currency_round_in_k).to eq('5.02') }
        end
      end

      context 'when currency is nil' do
        before { allow(subject).to receive(:currency_round).and_return(nil) }

        describe '#currency_round_in_k' do
          it { expect(subject.currency_round_in_k).to be_nil }
        end
      end
    end
  end
end
