# frozen_string_literal: true

# 月額変更届・70歳以上被用者月額変更届データレコード
module Kirico
  class DataRecord2221700 < ApplicationRecord
    DOC_CODE = '2221700'

    attribute :prefecture_code, String
    attribute :area_code, String
    attribute :office_code, String
    attribute :ip_code, String
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :birth_at, Date
    attribute :applied_at, Date
    attribute :old_monthly_standard_income_hel_ins, Integer
    attribute :old_monthly_standard_income_pns_ins, Integer
    attribute :old_applied_at, Date
    attribute :income_updated_at, Date
    attribute :income_updated_type, Symbol
    attribute :retroacted_payment_at, Date
    attribute :retroacted_payment, Integer
    [3, 2, 1].each do |month|
      attribute "before_#{month}_month_days", String
      attribute "before_#{month}_month_income_currency", String
      attribute "before_#{month}_month_income_goods", String
    end
    attribute :avg_adjustment, Integer
    attribute :my_number, String
    attribute :area_code_of_basic_pension_number, String
    attribute :serial_number_of_basic_pension_number, String
    attribute :seventy_years_and_over, Integer
    attribute :work_in_multiple_company, Integer
    attribute :short_time_worker, Integer
    attribute :reason, String
    attribute :change_only_hel_ins, Integer
    attribute :memo, String
    attribute :submit_only_seventy_years_and_over, Integer

    define_format_date_method :birth_at, :applied_at, :old_applied_at, :income_updated_at, :retroacted_payment_at
    define_code_mapper_method :birth_at_era_nengo, :applied_at_era_nengo, :old_applied_at_era_nengo, :income_updated_type
    define_in_k_method :old_monthly_standard_income_hel_ins, :old_monthly_standard_income_pns_ins

    validates :prefecture_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :ip_code, charset: { accept: [:numeric] }, sjis_bytesize: { in: 0..6 }, allow_blank: true
    validates :ip_name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :half_width }
    validates :ip_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..24 }, allow_blank: true, space_divider: { space: :full_width }
    validates :applied_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }
    validates :old_monthly_standard_income_hel_ins, numericality: { greater_than_or_equal_to: 1_000, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :old_monthly_standard_income_pns_ins, numericality: { greater_than_or_equal_to: 1_000, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :old_applied_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }
    validates :income_updated_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }, allow_blank: true
    validates :income_updated_type, inclusion: { in: %i[income_updated_type_0 income_updated_type_1] }, allow_blank: true
    validates :retroacted_payment_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }, allow_blank: true
    validates :retroacted_payment, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    [3, 2, 1].each do |month|
      validates "before_#{month}_month_income_currency", numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
      validates "before_#{month}_month_income_goods", numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
    end
    validates :avg_adjustment, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :my_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_nil: true
    validates :area_code_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_nil: true
    validates :serial_number_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 6 }, allow_nil: true
    validates :seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true
    validates :work_in_multiple_company, inclusion: { in: [1] }, allow_nil: true
    validates :short_time_worker, inclusion: { in: [1] }, allow_nil: true
    validates :reason, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }
    validates :change_only_hel_ins, inclusion: { in: [1] }, allow_nil: true
    validates :memo, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }, allow_nil: true
    validates :submit_only_seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true

    validate :each_month_days_should_be_greater_than_or_equal_11_or_17
    validate :seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number

    def initialize
      yield(self) if block_given?
    end

    # rubocop:disable all
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
        mapped_applied_at_era_nengo,
        applied_at_era_year,
        applied_at_month,
        old_monthly_standard_income_hel_ins.nil? ? nil : old_monthly_standard_income_hel_ins_in_k.to_s.rjust(4, '0'),
        old_monthly_standard_income_pns_ins.nil? ? nil : old_monthly_standard_income_pns_ins_in_k.to_s.rjust(4, '0'),
        mapped_old_applied_at_era_nengo,
        old_applied_at_era_year,
        old_applied_at_month,
        income_updated_at.nil? ? nil : income_updated_at_month,
        mapped_income_updated_type,
        retroacted_payment_at.nil? ? nil : retroacted_payment_at_month,
        retroacted_payment.nil? ? nil : retroacted_payment,
        applied_at.ago(3.months).strftime('%m'),
        applied_at.ago(2.months).strftime('%m'),
        applied_at.ago(1.month).strftime('%m'),
        before_3_month_days.to_s.rjust(2, '0'),
        before_2_month_days.to_s.rjust(2, '0'),
        before_1_month_days.to_s.rjust(2, '0'),
        before_3_month_income_currency,
        before_2_month_income_currency,
        before_1_month_income_currency,
        before_3_month_income_goods,
        before_2_month_income_goods,
        before_1_month_income_goods,
        round_income(income_total(before_3_month_income_currency, before_3_month_income_goods)),
        round_income(income_total(before_2_month_income_currency, before_2_month_income_goods)),
        round_income(income_total(before_1_month_income_currency, before_1_month_income_goods)),
        round_income(income_all_total),
        round_income(income_average),
        avg_adjustment.nil? ? nil : avg_adjustment,
        my_number,
        area_code_of_basic_pension_number,
        serial_number_of_basic_pension_number,
        seventy_years_and_over,
        work_in_multiple_company,
        short_time_worker,
        reason,
        change_only_hel_ins,
        memo,
        submit_only_seventy_years_and_over,
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
    # rubocop:enable all

    def income_total(currency, goods)
      currency.to_i + goods.to_i
    end

    def income_all_total
      [
        income_total(before_3_month_income_currency, before_3_month_income_goods),
        income_total(before_2_month_income_currency, before_2_month_income_goods),
        income_total(before_1_month_income_currency, before_1_month_income_goods)
      ].sum
    end

    # 1 円未満は切り捨て
    def income_average
      income_all_total / 3
    end

    def round_income(income)
      income < 10_000_000 ? income : 9_999_999
    end

    private

    # 一般の被保険者（短時間労働者以外）の場合、17～31 日の範囲で設定する
    # 短時間労働者（特定適用事業所のみ）の場合、11～31 日の範囲で設定する
    def each_month_days_should_be_greater_than_or_equal_11_or_17
      threshold = short_time_worker == 1 ? 11 : 17
      [3, 2, 1].each do |month|
        errors.add(:base, "前#{month}ヶ月の給与計算の基礎日数は、#{threshold}~31日の範囲で設定しなくてはいけません") unless threshold <= send(:"before_#{month}_month_days").to_i && send(:"before_#{month}_month_days").to_i <= 31
      end
    end

    def seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number
      return if seventy_years_and_over.nil?

      errors.add(:base, '70歳以上被用者の場合、マイナンバー、もしくは基礎年金番号の入力は必須です。') if my_number.nil? && area_code_of_basic_pension_number.nil? && serial_number_of_basic_pension_number.nil?
    end
  end
end
