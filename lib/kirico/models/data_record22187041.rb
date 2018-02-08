# frozen_string_literal: true

# 住所変更届データレコード
module Kirico
  class DataRecord22187041 < ApplicationRecord
    DOC_CODE = '22187041'

    attribute :area_code, String
    attribute :office_code, String
    attribute :ip_code, String
    attribute :basic_pension_number1, String
    attribute :basic_pension_number2, String
    attribute :birth_at, Date
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :new_address_yomi, String
    attribute :new_address, String
    attribute :updated_at, Date
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :old_address_yomi, String
    attribute :old_address, String
    attribute :memo, String

    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :ip_code, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..6 }
    validates :basic_pension_number1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :basic_pension_number2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 6 }, allow_blank: true
    validates :zip_code1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }
    validates :zip_code2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }
    validates :new_address_yomi, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..75 }
    validates :new_address, charset: { accept: [:all] }, sjis_bytesize: { in: 0..74 }, allow_blank: true
    validates :updated_at, timeliness: { on_or_before: :today, type: :date }
    validates :ip_name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :half_width }
    validates :ip_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..24 }, allow_blank: true, space_divider: { space: :full_width }
    validates :old_address_yomi, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..75 }
    validates :old_address, charset: { accept: [:all] }, sjis_bytesize: { in: 0..74 }, allow_blank: true
    validates :memo, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }, allow_blank: true

    define_format_date_method :birth_at, :updated_at
    define_code_mapper_method :birth_at_era_nengo, :updated_at_era_nengo

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        DOC_CODE,
        area_code,
        office_code,
        ip_code,
        basic_pension_number1,
        basic_pension_number2,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        zip_code1,
        zip_code2,
        new_address_yomi,
        new_address,
        mapped_updated_at_era_nengo,
        fmt_era_ymd_updated_at,
        ip_name_yomi,
        ip_name,
        old_address_yomi,
        old_address,
        memo
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
