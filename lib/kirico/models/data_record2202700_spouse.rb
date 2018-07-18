# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「配偶者である被扶養者」の情報
module Kirico
  class DataRecord2202700Spouse < ApplicationRecord
    attribute :submit_at, Date
    attribute :name_yomi, String
    attribute :name, String
    attribute :birth_at, Date
    attribute :gender_type, Symbol
    attribute :my_number_digits, String
    attribute :basic_pension_number1, String
    attribute :basic_pension_number2, String
    attribute :nationality, String
    attribute :foreign_name_kana, String
    attribute :foreign_name, String
    attribute :living_together_type, Symbol
    attribute :address_pref_type, Symbol
    attribute :zip_code1, String
    attribute :spoues_zip_code2, String
    attribute :address, String
    attribute :tel_number_type, Symbol
    attribute :tel_number1, String
    attribute :tel_number2, String
    attribute :tel_number3, String
    attribute :qualified_at, Date
    attribute :qualified_reason_type, Symbol
    attribute :qualified_reason_etc, String
    attribute :job_type, Symbol
    attribute :income, Integer
    attribute :disqualified_at, Date
    attribute :disqualified_reason_type, Symbol
    attribute :disqualified_reason_etc, String
    attribute :death_at, Date
    attribute :memo, String

    define_format_date_method :submit_at, :birth_at, :qualified_at, :disqualified_at, :death_at
    define_code_mapper_method :submit_at_era_nengo, :birth_at_era_nengo, :qualified_at_era_nengo,
                              :disqualified_at_era_nengo, :death_at_era_nengo
    define_code_mapper_method :gender_type, :living_together_type, :address_pref_type,
                              :tel_number_type, :qualified_reason_type, :job_type, :disqualified_reason_type

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        mapped_submit_at_era_nengo,
        fmt_era_ymd_submit_at,
        name_yomi,
        name,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        mapped_gender_type,
        my_number_digits,
        basic_pension_number1,
        basic_pension_number2,
        nationality,
        foreign_name_kana,
        foreign_name,
        mapped_living_together_type,
        mapped_address_pref_type,
        zip_code1,
        spoues_zip_code2,
        address,
        mapped_tel_number_type,
        tel_number1,
        tel_number2,
        tel_number3,
        mapped_qualified_at_era_nengo,
        fmt_era_ymd_qualified_at,
        mapped_qualified_reason_type,
        qualified_reason_etc,
        mapped_job_type,
        income.to_s.rjust(7, '0'),
        mapped_disqualified_at_era_nengo,
        fmt_era_ymd_disqualified_at,
        mapped_disqualified_reason_type,
        disqualified_reason_etc,
        mapped_death_at_era_nengo,
        fmt_era_ymd_death_at,
        memo
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
