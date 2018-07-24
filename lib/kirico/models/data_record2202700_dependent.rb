# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「その他の被扶養者1~3」の情報
module Kirico
  class DataRecord2202700Dependent < ApplicationRecord
    attribute :ip_code, String
    attribute :name, String
    attribute :name_yomi, String
    attribute :birth_at, Date
    attribute :gender_type, Symbol
    attribute :relation_type, Symbol
    attribute :relation_type_etc, String
    attribute :my_number_digits, String
    attribute :living_together_type, Symbol
    attribute :qualified_at, Date
    attribute :job_type, Symbol
    attribute :address_pref_type, Symbol
    attribute :income, Integer
    attribute :qualified_reason_type, Symbol
    attribute :qualified_reason_etc, String
    attribute :disqualified_at, Date
    attribute :disqualified_reason_type, Symbol
    attribute :disqualified_reason_etc, String
    attribute :memo, String

    define_format_date_method :birth_at, :qualified_at, :disqualified_at
    define_code_mapper_method :birth_at_era_nengo, :qualified_at_era_nengo, :disqualified_at_era_nengo
    define_code_mapper_method :gender_type, :relation_type, :living_together_type,
                              :job_type, :address_pref_type, :qualified_reason_type, :disqualified_reason_type
    define_padding_zero_method :income

    def to_csv
      [
        ip_code,
        name_yomi,
        name,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        mapped_gender_type,
        mapped_relation_type,
        relation_type_etc,
        my_number_digits,
        mapped_living_together_type,
        mapped_qualified_at_era_nengo,
        fmt_era_ymd_qualified_at,
        mapped_job_type,
        mapped_address_pref_type,
        padding_zero_income,
        mapped_qualified_reason_type,
        qualified_reason_etc,
        mapped_disqualified_at_era_nengo,
        fmt_era_ymd_disqualified_at,
        mapped_disqualified_reason_type,
        disqualified_reason_etc,
        memo
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
