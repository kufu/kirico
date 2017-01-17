# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Company do
  describe '#to_csv' do
    subject { Kirico::Company.new.to_csv }
    it { expect(subject.join(',')).to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,宮田昇始,03-5563-7662' }
  end
end
