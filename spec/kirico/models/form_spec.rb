# frozen_string_literal: true
require 'spec_helper'

describe Kirico::Form, type: :model do
  context 'when the form is for general use' do
    let(:record) { FactoryGirl.build(:form) }

    describe 'validations' do
      subject { record }
      it { is_expected.to validate_presence_of(:fd) }
      it { is_expected.to validate_presence_of(:company_count) }
      it { is_expected.to validate_presence_of(:company) }
      it { is_expected.to validate_presence_of(:records) }
    end

    describe '#validate_children' do
      context 'when there are some errors' do
        before do
          record.fd.area_code = '生卵'
          record.fd.office_code = '豚バラ肉'
        end
        it 'contains some error messages' do
          expect(record.valid?).to be_falsy
          expect(record.errors.full_messages.count).to eq 4
          expect(record.errors.full_messages[0]).to eq 'Fd Area code has invalid character(s): 生, 卵'
          expect(record.errors.full_messages[1]).to eq 'Fd Area code is the wrong length (should be 2 characters)'
          expect(record.errors.full_messages[2]).to eq 'Fd Office code has invalid character(s): 豚, バ, ラ, 肉'
          expect(record.errors.full_messages[3]).to eq 'Fd Office code is too long (maximum is 4 characters)'
        end
      end
    end

    describe '#to_csv' do
      let(:result) { record.to_csv.split("\r\n") }
      describe '1st line' do
        subject { result[0].encode('UTF-8') }
        it { is_expected.to eq '14,ｸﾄﾜ,005,20170117,22223' }
      end
      describe '2nd line' do
        subject { result[1].encode('UTF-8') }
        it { is_expected.to eq '[kanri]' }
      end
      describe '3rd line' do
        subject { result[2].encode('UTF-8') }
        it { is_expected.to eq ',001' }
      end
      describe '4th line' do
        subject { result[3].encode('UTF-8') }
        it { is_expected.to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,吉田　ケイ　松蔭,03-5563-7662' }
      end
      describe '5th line' do
        subject { result[4].encode('UTF-8') }
        it { is_expected.to eq '[data]' }
      end
      describe '6th line' do
        subject { result[5].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '7th line' do
        subject { result[6].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '8th line' do
        subject { result[7].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '9th line' do
        subject { result[8] }
        it { is_expected.to be_nil }
      end
    end
  end

  context 'when the form is for SR use' do
    let(:record) { FactoryGirl.build(:sr_form) }

    describe 'validations' do
      subject { record }
      it { is_expected.to validate_presence_of(:fd) }
      it { is_expected.to validate_presence_of(:company_count) }
      it { is_expected.to validate_presence_of(:company) }
      it { is_expected.to validate_presence_of(:records) }
    end

    describe '#validate_children' do
      context 'when there are some errors' do
        before do
          record.fd.sr_code = '生卵'
        end
        it 'contains some error messages' do
          expect(record.valid?).to be_falsy
          expect(record.errors.full_messages.count).to eq 1
          expect(record.errors.full_messages[0]).to eq 'Fd Sr code has invalid character(s): 生, 卵'
        end
      end
    end

    describe '#to_csv' do
      let(:result) { record.to_csv.split("\r\n") }
      describe '1st line' do
        subject { result[0].encode('UTF-8') }
        it { is_expected.to eq ',0007,004,20170227,22223' }
      end
      describe '2nd line' do
        subject { result[1].encode('UTF-8') }
        it { is_expected.to eq '[kanri]' }
      end
      describe '3rd line' do
        subject { result[2].encode('UTF-8') }
        it { is_expected.to eq '社労士　太郎,001' }
      end
      describe '4th line' do
        subject { result[3].encode('UTF-8') }
        it { is_expected.to eq '14,ｸﾄﾜ,77362,106,0041,東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601,株式会社クフ,吉田　ケイ　松蔭,03-5563-7662' }
      end
      describe '5th line' do
        subject { result[4].encode('UTF-8') }
        it { is_expected.to eq '[data]' }
      end
      describe '6th line' do
        subject { result[5].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '7th line' do
        subject { result[6].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '8th line' do
        subject { result[7].encode('UTF-8') }
        it { is_expected.to eq '22187041,14,ｸﾄﾜ,000010,2271,174711,5,620527,154,0011,ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ,東京都世田谷区上馬,7,290103,ﾀﾅｶ ﾀﾛｳ,田中　太郎,ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ,東京都練馬区豊玉上2-5-1モゲラ801,備考備考' }
      end
      describe '9th line' do
        subject { result[8] }
        it { is_expected.to be_nil }
      end
    end
  end
end
