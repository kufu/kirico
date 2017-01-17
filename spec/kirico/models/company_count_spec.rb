# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyCount do
  describe '#to_csv' do
    subject { Kirico::CompanyCount.new.to_csv }
    it { is_expected.to eq ',001' }
  end
end
