# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyCount do
  describe '#to_csv' do
    subject { Kirico::Company.new.to_csv }
    it { expect(subject.join(',')).to eq ',001' }
  end
end
