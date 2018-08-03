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

    # FIXME: 共通化できそ
    validates :address_pref_type, inclusion: { in: %i[
      address_pref_type_01 address_pref_type_02 address_pref_type_03 address_pref_type_04 address_pref_type_05
      address_pref_type_06 address_pref_type_07 address_pref_type_08 address_pref_type_09 address_pref_type_10
      address_pref_type_11 address_pref_type_12 address_pref_type_21 address_pref_type_31 address_pref_type_32
      address_pref_type_33 address_pref_type_34 address_pref_type_35 address_pref_type_36 address_pref_type_37
      address_pref_type_38 address_pref_type_39 address_pref_type_41 address_pref_type_42 address_pref_type_51
      address_pref_type_52 address_pref_type_53 address_pref_type_54 address_pref_type_55 address_pref_type_56
      address_pref_type_57 address_pref_type_58 address_pref_type_59 address_pref_type_60 address_pref_type_61
      address_pref_type_71 address_pref_type_72 address_pref_type_73 address_pref_type_74 address_pref_type_75
      address_pref_type_76 address_pref_type_77 address_pref_type_78 address_pref_type_79 address_pref_type_80
      address_pref_type_81 address_pref_type_82
    ] }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :owner_confirmation_type, inclusion: { in: %i[
      owner_confirmation_type_0 owner_confirmation_type_1
    ] }, allow_blank: true
    validates :ip_code, charset: { accept: [:numeric] }, sjis_bytesize: { in: 0..6 }, allow_blank: true
    validates :ip_name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :half_width }
    validates :ip_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..12 }, space_divider: { space: :full_width }
    validates :gender_type, inclusion: { in: %i[gender_type_1 gender_type_2] }
    validates :my_number_digits, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_blank: true
    validates :basic_pension_number1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :basic_pension_number2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 6 }, allow_blank: true
    validates :salary, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :zip_code1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }, allow_blank: true
    validates :zip_code2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :address, charset: { accept: [:all] }, sjis_bytesize: { in: 0..74 }, allow_blank: true
    validates :change_type, inclusion: { in: %i[
      change_type_1 change_type_2 change_type_3
    ] }
    validates :spouse_annual_income, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true

    define_format_date_method :owner_accepted_at, :birth_at
    define_code_mapper_method :owner_accepted_at_era_nengo, :birth_at_era_nengo
    define_code_mapper_method :address_pref_type, :owner_confirmation_type, :gender_type, :change_type
    define_padding_zero_method :salary, :spouse_annual_income
    define_conditional_display_method :padding_zero_salary do |rec|
      rec.change_type == :change_type_1
    end
    define_conditional_display_method :zip_code1, :zip_code2, :address do |rec|
      obj.my_number_digits.present?
    end

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
        cond_padding_zero_salary,
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
