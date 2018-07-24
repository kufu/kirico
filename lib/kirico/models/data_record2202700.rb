# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコード
module Kirico
  class DataRecord2202700 < ApplicationRecord
    DOC_CODE = '2202700'

    attribute :address_pref_type, Symbol
    attribute :area_code, String
    attribute :office_code, String
    attribute :owner_confirmation_type, Symbol
    attribute :owner_accepted_at, Date
    attribute :ip_code, String
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :birth_at, Date
    attribute :gender_type, Symbol
    attribute :my_number_digits, String
    attribute :basic_pension_number1, String
    attribute :basic_pension_number2, String
    attribute :salary, Integer
    attribute :zip_code1, String
    attribute :zip_code2, String
    attribute :address, String
    attribute :change_type, Symbol
    attribute :spouse_record, DataRecord2202700Spouse
    attribute :spouse_annual_income, Integer
    attribute :dependent_record1, DataRecord2202700Dependent
    attribute :dependent_record2, DataRecord2202700Dependent
    attribute :dependent_record3, DataRecord2202700Dependent

    define_format_date_method :owner_accepted_at, :birth_at
    define_code_mapper_method :owner_accepted_at_era_nengo, :birth_at_era_nengo
    define_code_mapper_method :address_pref_type, :owner_confirmation_type, :gender_type, :change_type
    define_padding_zero_method :salary

    def initialize
      yield(self) if block_given?
      self.spouse_record ||= DataRecord2202700Spouse.new
      self.dependent_record1 ||= DataRecord2202700Dependent.new
      self.dependent_record2 ||= DataRecord2202700Dependent.new
      self.dependent_record3 ||= DataRecord2202700Dependent.new
    end

    def to_csv
      [
        DOC_CODE,
        mapped_address_pref_type,
        area_code,
        office_code,
        mapped_owner_confirmation_type,
        mapped_owner_accepted_at_era_nengo,
        fmt_era_ymd_owner_accepted_at,
        ip_code,
        ip_name_yomi,
        ip_name,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        mapped_gender_type,
        my_number_digits,
        basic_pension_number1,
        basic_pension_number2,
        padding_zero_salary,
        zip_code1,
        zip_code2,
        address,
        mapped_change_type,
        spouse_record.to_csv,
        spouse_annual_income,
        dependent_record1.to_csv,
        dependent_record2.to_csv,
        dependent_record3.to_csv
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
