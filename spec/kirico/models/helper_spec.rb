# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Helper do
  describe '#define_format_date_method' do
    class HelperMock
      extend Kirico::Helper
      define_format_date_method :created_at
    end

    let(:obj) { HelperMock.new }

    describe '#fmt_created_at' do
      subject { obj.fmt_created_at }

      context 'when created_at is nil' do
        before { allow(obj).to receive(:created_at).and_return(nil) }
        it { is_expected.to be_nil }
      end
      context 'when created_at is 1984-07-23' do
        before { allow(obj).to receive(:created_at).and_return(Date.new(1984, 7, 23)) }
        it { is_expected.to eq '19840723' }
      end
    end
  end
end
