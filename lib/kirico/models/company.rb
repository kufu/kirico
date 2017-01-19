# frozen_string_literal: true
require 'virtus'

module Kirico
  class Company
    include Virtus.model

    attribute :area_code, String
    attribute :office_code, String
    attribute :office_number, String
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :address, String
    attribute :name, String
    attribute :owner_name, String
    attribute :tel_number, String

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
      ].join(',')
    end
  end
end
