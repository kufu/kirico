# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「配偶者である被扶養者」の情報
module Kirico
  class DataRecord2202700Spouse < ApplicationRecord
    # NOTE: 親（DataRecord2202700）の値と同じ値が設定されている想定
    # 本来であれば親経由で親の異動の別にアクセスしたかった。
    # 実装が複雑になってしまうので子に直接設定している。
    attribute :change_type, Symbol

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
    attribute :zip_code2, String
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

    validates :change_type, inclusion: { in: %i[
      change_type_1 change_type_2 change_type_3
    ] }
    validates :name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 0..25 }, space_divider: { space: :half_width }, allow_blank: true
    validates :name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..12 }, space_divider: { space: :full_width }, allow_blank: true
    validates :my_number_digits, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_blank: true
    validates :gender_type, inclusion: { in: %i[gender_type_1 gender_type_2 gender_type_3 gender_type_4] }, allow_blank: true
    validates :basic_pension_number1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :basic_pension_number2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 6 }, allow_blank: true
    validates :nationality, charset: { accept: [:all] }, sjis_bytesize: { in: 0..15 }, allow_blank: true
    validates :foreign_name_kana, charset: { accept: [:katakana] }, sjis_bytesize: { in: 0..25 }, allow_blank: true
    validates :foreign_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..12 }, space_divider: { space: :full_width }, allow_blank: true
    validates :living_together_type, inclusion: { in: %i[living_together_type_1 living_together_type_2] }, allow_blank: true
    validates :living_together_type, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_1 }
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
    validates :zip_code1, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }, allow_blank: true
    validates :zip_code1, presence: true, if: :assigned?
    validates :zip_code2, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :zip_code2, presence: true, if: :assigned?
    validates :address, charset: { accept: [:all] }, sjis_bytesize: { in: 0..74 }, allow_blank: true
    validates :address, presence: true, if: :assigned?
    validates :tel_number_type, inclusion: { in: %i[tel_number_type_1 tel_number_type_2 tel_number_type_3 tel_number_type_4] }, allow_blank: true
    validates :tel_number1, charset: { accept: [:numeric] }, sjis_bytesize: { in: 2..5 }, allow_blank: true
    validates :tel_number2, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..4 }, allow_blank: true
    validates :tel_number3, charset: { accept: [:numeric] }, sjis_bytesize: { in: 4..5 }, allow_blank: true
    validates :qualified_at, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_1 }
    validates :qualified_reason_type, inclusion: { in: %i[
      qualified_reason_type_1 qualified_reason_type_2 qualified_reason_type_3
      qualified_reason_type_4 qualified_reason_type_5
    ] }, allow_blank: true
    validates :qualified_reason_type, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_1 }
    validates :qualified_reason_etc, charset: { accept: [:all] }, sjis_bytesize: { in: 0..48 }, allow_blank: true
    validates :qualified_reason_etc, presence: true, if: proc { |rec| rec.qualified_reason_type == :qualified_reason_type_5 }
    validates :job_type, inclusion: { in: %i[job_type_1 job_type_2 job_type_3 job_type_4] }, allow_blank: true
    validates :job_type, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_1 }
    validates :income, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :income, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_1 }
    validates :disqualified_at, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_2 }
    validates :disqualified_reason_type, inclusion: { in: %i[
      disqualified_reason_type_1 disqualified_reason_type_2 disqualified_reason_type_3
      disqualified_reason_type_4 disqualified_reason_type_5 disqualified_reason_type_6
    ] }, allow_blank: true
    validates :disqualified_reason_type, presence: true, if: proc { |rec| rec.assigned? && rec.change_type == :change_type_2 }
    validates :disqualified_reason_etc, charset: { accept: [:all] }, sjis_bytesize: { in: 0..48 }, allow_blank: true
    validates :death_at, presence: true, if: proc { |rec| rec.disqualified_reason_type == :disqualified_reason_type_1 }
    validates :memo, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }, allow_blank: true

    define_format_date_method :submit_at, :birth_at, :qualified_at, :disqualified_at, :death_at
    define_code_mapper_method :submit_at_era_nengo, :birth_at_era_nengo, :qualified_at_era_nengo,
                              :disqualified_at_era_nengo, :death_at_era_nengo
    define_code_mapper_method :gender_type, :living_together_type, :address_pref_type,
                              :tel_number_type, :qualified_reason_type, :job_type, :disqualified_reason_type
    define_padding_zero_method :income

    define_conditional_display_method :mapped_living_together_type, :mapped_qualified_reason_type,
                                      :mapped_job_type, :padding_zero_income do |rec|
      rec.change_type == :change_type_1
    end

    define_conditional_display_method :mapped_address_pref_type do |rec|
      rec.change_type == :change_type_2
    end

    define_conditional_display_method :mapped_qualified_at_era_nengo, :fmt_era_ymd_qualified_at do |rec|
      rec.change_type == :change_type_1 || rec.change_type == :change_type_3
    end

    define_conditional_display_method :mapped_disqualified_at_era_nengo, :fmt_era_ymd_disqualified_at do |rec|
      rec.change_type == :change_type_2 || rec.change_type == :change_type_3
    end

    define_conditional_display_method :mapped_disqualified_reason_type do |rec|
      rec.change_type == :change_type_2
    end

    define_conditional_display_method :mapped_death_at_era_nengo do |rec|
      rec.disqualified_reason_type == :disqualified_reason_type_1
    end

    define_conditional_display_method :memo do |rec|
      rec.change_type == :change_type_3
    end

    def initialize
      yield(self) if block_given?
    end

    # 主要な項目を検証し、配偶者である被扶養者情報として
    # 設定されているかを判定する
    def assigned?
      submit_at.present? || name.present? || name_yomi.present? || birth_at.present?
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
        cond_mapped_living_together_type,
        cond_mapped_address_pref_type,
        zip_code1,
        zip_code2,
        address,
        mapped_tel_number_type,
        tel_number1,
        tel_number2,
        tel_number3,
        cond_mapped_qualified_at_era_nengo,
        cond_fmt_era_ymd_qualified_at,
        cond_mapped_qualified_reason_type,
        qualified_reason_etc,
        cond_mapped_job_type,
        cond_padding_zero_income,
        cond_mapped_disqualified_at_era_nengo,
        cond_fmt_era_ymd_disqualified_at,
        cond_mapped_disqualified_reason_type,
        disqualified_reason_etc,
        cond_mapped_death_at_era_nengo,
        fmt_era_ymd_death_at,
        memo
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
