# frozen_string_literal: true

# 賞与支払届データレコード
module Kirico
  class DataRecord2265700 < ApplicationRecord
    DOC_CODE = '2265700'

    attribute :prefecture_code, String
    attribute :area_code, String
    attribute :office_code, String
    attribute :ip_code, String
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :birth_at, Date
    attribute :bonus_payment_at, Date
    attribute :payment_in_currency, Integer
    attribute :payment_in_goods, Integer
    attribute :my_number, String
    attribute :area_code_of_basic_pension_number, String
    attribute :serial_number_of_basic_pension_number, String
    attribute :seventy_years_and_over, Integer
    attribute :work_in_multiple_company, Integer
    attribute :first_payment_day_of_multiple_payments_within_the_same_month, String
    attribute :submit_only_seventy_years_and_over, Integer

    define_format_date_method :birth_at, :bonus_payment_at
    define_code_mapper_method :birth_at_era_nengo, :bonus_payment_at_era_nengo

    validates :prefecture_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :ip_code, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..6 }
    validates :ip_name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :half_width }
    validates :ip_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..24 }, allow_blank: true, space_divider: { space: :full_width }
    validates :bonus_payment_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }
    validates :payment_in_currency, numericality: { greater_than_or_equal_to: 0 }
    validates :payment_in_goods, numericality: { greater_than_or_equal_to: 0 }
    validates :my_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_nil: true
    validates :area_code_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_nil: true
    validates :serial_number_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 6 }, allow_nil: true
    validates :seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true
    validates :work_in_multiple_company, inclusion: { in: [1] }, allow_nil: true
    validates :first_payment_day_of_multiple_payments_within_the_same_month, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }, allow_nil: true
    validates :submit_only_seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true
    validate :seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        DOC_CODE,
        prefecture_code,
        area_code,
        office_code,
        ip_code,
        ip_name_yomi,
        ip_name,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        mapped_bonus_payment_at_era_nengo,
        fmt_era_ymd_bonus_payment_at,
        adjusted_payment_in_currency,
        adjusted_payment_in_goods,
        bonus_total(payment_in_currency, payment_in_goods),
        my_number,
        area_code_of_basic_pension_number,
        serial_number_of_basic_pension_number,
        seventy_years_and_over,
        work_in_multiple_company,
        first_payment_day_of_multiple_payments_within_the_same_month,
        submit_only_seventy_years_and_over
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end

    def bonus_total(currency, goods)
      total = currency.to_i + goods.to_i
      total >= 10_000_000 ? 9_999_000 : total.floor(-3)
    end

    def adjusted_payment_in_currency
      payment_in_currency < 10_000_000 ? payment_in_currency : 9_999_999
    end

    def adjusted_payment_in_goods
      payment_in_goods < 10_000_000 ? payment_in_goods : 9_999_999
    end

    private

    def seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number
      return if seventy_years_and_over.nil?

      errors.add(:base, '70歳以上被用者の場合、マイナンバー、もしくは基礎年金番号の入力は必須です。') if my_number.nil? && area_code_of_basic_pension_number.nil? && serial_number_of_basic_pension_number.nil?
    end
  end
end
