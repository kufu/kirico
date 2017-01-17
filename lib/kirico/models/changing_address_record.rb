# frozen_string_literal: true
require 'virtus'
require 'kirico/models/helper'

module Kirico
  class ChangingAddressRecord
    include Virtus.model
    extend Kirico::Helper

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
      ].join(',')
    end
  end
end
