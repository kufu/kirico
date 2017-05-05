# frozen_string_literal: true
require 'spec_helper'

describe Kirico::SpaceDividerValidator do
  describe '#check_validity!' do
    context 'when specifying valid :space option' do
      let(:options) { { attributes: :hoge, space: :half_width } }
      it 'does NOT raise an ArgumentError' do
        expect(
          Kirico::SpaceDividerValidator.new(options)
        ).to be_a(Kirico::SpaceDividerValidator)
      end
    end

    context 'when specifying w/o any options' do
      let(:options) { { attributes: :hoge } }
      it 'does NOT raise an ArgumentError' do
        expect(
          Kirico::SpaceDividerValidator.new(options)
        ).to be_a(Kirico::SpaceDividerValidator)
      end
    end

    context 'when specifying invalid :space option' do
      let(:options) { { attributes: :hoge, space: :foo } }
      it 'does raise an ArgumentError' do
        expect {
          Kirico::SpaceDividerValidator.new(options)
        }.to raise_error(ArgumentError, 'Invalid space option foo. Specify the :full_width, half_width, or :both_width.')
      end
    end
  end

  describe '#validate_each' do
    context 'when :space option is :full_width' do
      subject { SpaceDividerTestFullWidth.new(my_field: my_field).valid? }
      context 'when the field is nil' do
        let(:my_field) { nil }
        it { is_expected.to be_falsy }
      end
      context 'when there are NOT any spaces' do
        let(:my_field) { '東京都世田谷区上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a full width space between string' do
        let(:my_field) { '東京都　世田谷区　上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some full width spaces between string' do
        let(:my_field) { '東京都　　世田谷区　　上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a half width space between string' do
        let(:my_field) { '東京都 世田谷区 上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there are some half width spaces between string' do
        let(:my_field) { '東京都  世田谷区  上馬' }
        it { is_expected.to be_falsy }
      end
    end
    context 'when :space option is :half_width' do
      subject { SpaceDividerTestHalfWidth.new(my_field: my_field).valid? }
      context 'when the field is nil' do
        let(:my_field) { nil }
        it { is_expected.to be_falsy }
      end
      context 'when there are NOT any spaces' do
        let(:my_field) { '東京都世田谷区上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a full width space between string' do
        let(:my_field) { '東京都　世田谷区　上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there are some full width spaces between string' do
        let(:my_field) { '東京都　　世田谷区　　上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a half width space between string' do
        let(:my_field) { '東京都 世田谷区 上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some half width spaces between string' do
        let(:my_field) { '東京都  世田谷区  上馬' }
        it { is_expected.to be_falsy }
      end
    end
    context 'when :space option is :both_width' do
      subject { SpaceDividerTestBothWidth.new(my_field: my_field).valid? }
      context 'when the field is nil' do
        let(:my_field) { nil }
        it { is_expected.to be_falsy }
      end
      context 'when there are NOT any spaces' do
        let(:my_field) { '東京都世田谷区上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a full width space between string' do
        let(:my_field) { '東京都　世田谷区　上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some full width spaces between string' do
        let(:my_field) { '東京都　　世田谷区　　上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a half width space between string' do
        let(:my_field) { '東京都 世田谷区 上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some half width spaces between string' do
        let(:my_field) { '東京都  世田谷区  上馬' }
        it { is_expected.to be_falsy }
      end
    end
    context 'when :space option is :blank' do
      subject { SpaceDividerTestDefault.new(my_field: my_field).valid? }
      context 'when the field is nil' do
        let(:my_field) { nil }
        it { is_expected.to be_falsy }
      end
      context 'when there are NOT any spaces' do
        let(:my_field) { '東京都世田谷区上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a full width space between string' do
        let(:my_field) { '東京都　世田谷区　上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some full width spaces between string' do
        let(:my_field) { '東京都　　世田谷区　　上馬' }
        it { is_expected.to be_falsy }
      end
      context 'when there is a half width space between string' do
        let(:my_field) { '東京都 世田谷区 上馬' }
        it { is_expected.to be_truthy }
      end
      context 'when there are some half width spaces between string' do
        let(:my_field) { '東京都  世田谷区  上馬' }
        it { is_expected.to be_falsy }
      end
    end
  end
end
