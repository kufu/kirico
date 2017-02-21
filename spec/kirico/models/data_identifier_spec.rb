# frozen_string_literal: true
require 'spec_helper'

describe Kirico::DataIdentifier, type: :model do
  describe '#to_csv' do
    subject { Kirico::DataIdentifier.new.to_csv.encode('UTF-8') }
    it { is_expected.to eq '[data]' }
  end
end
