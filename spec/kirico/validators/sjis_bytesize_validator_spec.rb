# frozen_string_literal: true
require 'spec_helper'

describe Kirico::SjisBytesizeValidator do
  describe '#initialize' do
    context 'when specifying :in by Range' do
      let(:options) { { attributes: :hoge, in: 1..3 } }
      it 'does NOT raise any errors' do
        expect(Kirico::SjisBytesizeValidator.new(options)).to be_a(Kirico::SjisBytesizeValidator)
      end
    end

    context 'when specifying :in by Integer' do
      let(:options) { { attributes: :hoge, in: 999 } }
      it 'does raise an ArgumentError' do
        expect {
          Kirico::SjisBytesizeValidator.new(options)
        }.to raise_error(ArgumentError, ':in and :within must be a Range')
      end
    end

    context 'when specifying w/o any options' do
      let(:options) { { attributes: :hoge } }
      it 'does raise an ArgumentError' do
        expect {
          Kirico::SjisBytesizeValidator.new(options)
        }.to raise_error(ArgumentError, 'Range unspecified. Specify the :in, :within, :maximum, :minimum, or :is option.')
      end

      context 'when specifying string' do
        let(:options) { { attributes: :hoge, maximum: 'foo' } }
        it 'does raise an ArgumentError' do
          expect {
            Kirico::SjisBytesizeValidator.new(options)
          }.to raise_error(ArgumentError, ':maximum must be a nonnegative Integer or Infinity')
        end
      end

      context 'when specifying negative integer' do
        let(:options) { { attributes: :hoge, maximum: -1 } }
        it 'does raise an ArgumentError' do
          expect {
            Kirico::SjisBytesizeValidator.new(options)
          }.to raise_error(ArgumentError, ':maximum must be a nonnegative Integer or Infinity')
        end
      end
    end
  end

  context 'when the string is nil' do
    it 'should be invlaid' do
      expect(SjisBytesizeTestIs3.new(my_field: nil)).not_to be_valid
    end
  end

  context 'when the string is NOT in CP932（U+301C: WAVE DASH）' do
    it 'counts the chars length as 1' do
      expect(SjisBytesizeTestIs3.new(my_field: '〜〜〜')).to be_valid
    end
  end

  context 'when the string contains（U+FF0D: FULLWIDTH HYPHEN-MINUS）' do
    it 'counts the char length as 2' do
      expect(SjisBytesizeTestIs3.new(my_field: 'x－')).to be_valid
    end
  end

  describe 'validate w/ option { is: 3 }' do
    context 'given valid lenght of strings' do
      %w(123 ｱｲｳ abc あx).each do |str|
        it "#{str} should be valid" do
          expect(SjisBytesizeTestIs3.new(my_field: str)).to be_valid
        end
      end
    end

    context 'given invalid lenght of strings' do
      ['', '1', '22', '4444'].each do |str|
        it "#{str} should be invalid" do
          expect(SjisBytesizeTestIs3.new(my_field: str)).not_to be_valid
        end
      end
    end
  end

  describe 'validate w/ option { within: 3..5 }' do
    context 'given valid lenght of strings' do
      %w(333 4444 55555).each do |str|
        it "#{str} should be valid" do
          expect(SjisBytesizeTestRange3to5.new(my_field: str)).to be_valid
        end
      end
    end

    context 'given invalid lenght of strings' do
      ['', '1', '22', '666666'].each do |str|
        it "#{str} should be invalid" do
          expect(SjisBytesizeTestRange3to5.new(my_field: str)).not_to be_valid
        end
      end
    end
  end

  describe 'validate w/ option { minimum: 5 }' do
    context 'given valid lenght of strings' do
      %w(55555 666666 7777777).each do |str|
        it "#{str} should be valid" do
          expect(SjisBytesizeTestMin5.new(my_field: str)).to be_valid
        end
      end
    end

    context 'given invalid lenght of strings' do
      ['', '1', '22', '333', '4444'].each do |str|
        it "#{str} should be invalid" do
          expect(SjisBytesizeTestMin5.new(my_field: str)).not_to be_valid
        end
      end
    end
  end

  describe 'validate w/ option { maximum: 5 }' do
    context 'given valid lenght of strings' do
      ['', '1', '22', '333', '4444', '55555'].each do |str|
        it "#{str} should be valid" do
          expect(SjisBytesizeTestMax5.new(my_field: str)).to be_valid
        end
      end
    end

    context 'given invalid lenght of strings' do
      %w(666666 7777777).each do |str|
        it "#{str} should be invalid" do
          expect(SjisBytesizeTestMax5.new(my_field: str)).not_to be_valid
        end
      end
    end
  end

  describe 'validate w/ option { minimum: 3, maximum: 5 }' do
    context 'given valid lenght of strings' do
      %w(333 4444 55555).each do |str|
        it "#{str} should be valid" do
          expect(SjisBytesizeTestMin3Max5.new(my_field: str)).to be_valid
        end
      end
    end

    context 'given invalid lenght of strings' do
      ['', '1', '22', '666666'].each do |str|
        it "#{str} should be invalid" do
          expect(SjisBytesizeTestMin3Max5.new(my_field: str)).not_to be_valid
        end
      end
    end
  end
end
