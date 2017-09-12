# frozen_string_literal: true

require 'spec_helper'

describe Kirico::SrFDManagementRecord, type: :model do
  let(:record) { FactoryGirl.build(:sr_fd_management_record) }

  describe '#to_csv' do
    subject { record.to_csv.encode('UTF-8') }
    it { is_expected.to eq ',0007,004,20170227,22223' }
  end
end
