# frozen_string_literal: true
require 'virtus'
require 'active_model'

module Kirico
  class Company
    include Virtus.model
    include ActiveModel::Validations

    attribute :area_code, String
    attribute :office_code, String
    attribute :office_number, String
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :address, String
    attribute :name, String
    attribute :owner_name, String
    attribute :tel_number, String

    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: [:numeric, :latin, :katakana] }, sjis_bytesize: { in: 1..4 }
    validates :office_number, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..5 }
    validates :zip_code1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }
    validates :zip_code2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }
    validates :address, charset: { accept: [:all] }, sjis_bytesize: { in: 1..75 }
    validates :name, charset: { accept: [:katakana, :kanji] }, sjis_bytesize: { in: 1..50 }
    validates :owner_name, charset: { accept: [:katakana, :kanji] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :both_width }
    validates :tel_number, charset: { accept: [:latin, :numeric] }, sjis_bytesize: { in: 1..12 }

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        area_code,
        office_code,
        office_number,
        zip_code1,
        zip_code2,
        address,
        name,
        owner_name,
        tel_number
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
