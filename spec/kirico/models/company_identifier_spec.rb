# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyIdentifier, type: :model do
  describe '#to_csv' do
    subject { Kirico::CompanyIdentifier.new.to_csv }
    it { is_expected.to eq '[kanri]' }
  end
end
