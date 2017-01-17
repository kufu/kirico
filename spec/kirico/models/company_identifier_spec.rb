# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyIdentifier do
  describe '#to_csv' do
    subject { Kirico::CompanyIdentifier.new.to_csv }
    it { expect(subject.join(',')).to eq '[kanri]' }
  end
end
