# frozen_string_literal: true
require 'spec_helper'

describe Kirico::FDManagementRecord do
  describe '#to_csv' do
    subject { Kirico::FDManagementRecord.new.to_csv }
    it { is_expected.to eq '14,ｸﾄﾜ,005,20170117,22223' }
  end
end
