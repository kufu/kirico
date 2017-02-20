# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Company, type: :model do
  describe '#to_csv' do
    subject { FactoryGirl.build(:company).to_csv }
    it { is_expected.to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,宮田昇始,03-5563-7662' }
  end
end
