# frozen_string_literal: true

require 'virtus'
require 'active_model'

module Kirico
  class Company
    include Virtus.model
    include ActiveModel::Validations

    attribute :prefecture_code, String
    attribute :area_code, String
    attribute :office_code, String
    attribute :office_number, String
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :address, String
    attribute :name, String
    attribute :owner_name, String
    attribute :tel_area_code, String
    attribute :tel_city_code, String
    attribute :tel_subscriber_number, String

    validates :prefecture_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :office_number, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..5 }
    validates :zip_code1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }
    validates :zip_code2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }
    validates :address, charset: { accept: [:all] }, sjis_bytesize: { in: 1..75 }
    validates :name, charset: { accept: %i[katakana kanji] }, sjis_bytesize: { in: 1..50 }
    validates :owner_name, charset: { accept: %i[katakana kanji] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :both_width }
    validates :tel_area_code, charset: { accept: %i[latin numeric] }, sjis_bytesize: { in: 2..5 }
    validates :tel_city_code, charset: { accept: %i[latin numeric] }, sjis_bytesize: { in: 1..4 }
    validates :tel_subscriber_number, charset: { accept: %i[latin numeric] }, sjis_bytesize: { in: 4..5 }

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        prefecture_code,
        area_code,
        office_code,
        office_number,
        zip_code1,
        zip_code2,
        address,
        name,
        owner_name,
        tel_area_code,
        tel_city_code,
        tel_subscriber_number
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
