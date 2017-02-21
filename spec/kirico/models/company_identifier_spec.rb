# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyIdentifier, type: :model do
  describe '#to_csv' do
    subject { Kirico::CompanyIdentifier.new.to_csv.encode('UTF-8') }
    it { is_expected.to eq '[kanri]' }
  end
end
