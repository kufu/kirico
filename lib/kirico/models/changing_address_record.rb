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
    attribute :birth_at_era_code, String
    attribute :birth_at, String
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :new_address_yomi, String
    attribute :new_address, String
    attribute :updated_at_era_code, String
    attribute :updated_at, String
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :old_address_yomi, String
    attribute :old_address, String
    attribute :memo, String

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
        birth_at_era_code,
        birth_at,
        zip_code1,
        zip_code2,
        new_address_yomi,
        new_address,
        updated_at_era_code,
        updated_at,
        ip_name_yomi,
        ip_name,
        old_address_yomi,
        old_address,
        memo
      ].join(',')
    end
  end
end
