# frozen_string_literal: true
require 'spec_helper'

describe Kirico::CompanyCount, type: :model do
  let(:record) { FactoryGirl.build(:company_count) }

  describe '#to_csv' do
    subject { record.to_csv.encode('UTF-8') }
    it { is_expected.to eq ',001' }
  end
end
