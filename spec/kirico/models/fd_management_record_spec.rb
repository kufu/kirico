# frozen_string_literal: true
require 'spec_helper'

describe Kirico::FDManagementRecord do
  let(:record) { FactoryGirl.build(:fd_management_record) }

  describe '#to_csv' do
    subject { record.to_csv }
    it { is_expected.to eq '14,ｸﾄﾜ,005,20170117,22223' }
  end

  describe '#fmt_created_at' do
    subject { record.fmt_created_at }

    context 'when created_at is nil' do
      before { record.created_at = nil }
      it { is_expected.to be_nil }
    end

    context 'when created_at is 2017-01-01' do
      before { record.created_at = Date.new(2017, 1, 1) }
      it { is_expected.to eq '20170101' }
    end
  end
end
