# frozen_string_literal: true
require 'spec_helper'

describe Kirico::SrCompanyCount, type: :model do
  let(:record) { FactoryGirl.build(:sr_company_count) }

  describe '#to_csv' do
    subject { record.to_csv.encode('UTF-8') }
    it { is_expected.to eq '社労士　太郎,001' }
  end
end
