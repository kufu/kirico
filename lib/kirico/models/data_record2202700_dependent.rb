# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「その他の被扶養者1~3」の情報
module Kirico
  class DataRecord2202700Dependent < ApplicationRecord
    attribute :ip_code, String
    attribute :name_yomi, String
    attribute :name, String
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

    validates :name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 0..25 }, space_divider: { space: :half_width }, allow_blank: true
    validates :name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..12 }, space_divider: { space: :full_width }, allow_blank: true
    validates :gender_type, inclusion: { in: %i[gender_type_1 gender_type_2] }, allow_blank: true
    validates :relation_type, inclusion: { in: %i[
      relation_type_01 relation_type_02 relation_type_03 relation_type_04 relation_type_05
      relation_type_06 relation_type_07 relation_type_08 relation_type_09 relation_type_10
    ] }, allow_blank: true
    validates :relation_type_etc, charset: { accept: [:all] }, sjis_bytesize: { in: 0..24 }, allow_blank: true
    validates :my_number_digits, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_blank: true
    validates :living_together_type, inclusion: { in: %i[living_together_type_1 living_together_type_2] }, allow_blank: true
    validates :job_type, inclusion: { in: %i[
      job_type_1 job_type_2 job_type_3
      job_type_4 job_type_5 job_type_6
    ] }, allow_blank: true
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
    ] }, allow_blank: true
    validates :income, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :qualified_reason_type, inclusion: { in: %i[
      qualified_reason_type_1 qualified_reason_type_2 qualified_reason_type_3
      qualified_reason_type_4 qualified_reason_type_5
    ] }, allow_blank: true
    validates :qualified_reason_etc, charset: { accept: [:all] }, sjis_bytesize: { in: 0..48 }, allow_blank: true
    validates :disqualified_reason_type, inclusion: { in: %i[
      disqualified_reason_type_1 disqualified_reason_type_2 disqualified_reason_type_3
      disqualified_reason_type_4 disqualified_reason_type_5 disqualified_reason_type_6
    ] }, allow_blank: true
    validates :disqualified_reason_etc, charset: { accept: [:all] }, sjis_bytesize: { in: 0..48 }, allow_blank: true
    validates :memo, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }, allow_blank: true

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
