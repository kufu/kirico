# frozen_string_literal: true

# 2018年3月以降の算定基礎届データレコード
module Kirico
  class DataRecord2225700 < ApplicationRecord
    DOC_CODE = '2225700'
    COVERED_MONTHS = %i[apr may jun].freeze

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
    COVERED_MONTHS.each do |month|
      attribute "#{month}_days", Integer
      attribute "#{month}_income_currency", Integer
      attribute "#{month}_income_goods", Integer
    end
    attribute :avg_adjustment, Integer
    attribute :my_number, String
    attribute :ip_type, Symbol
    attribute :area_code_of_basic_pension_number, Integer
    attribute :serial_number_of_basic_pension_number, Integer
    attribute :seventy_years_and_over, Integer
    attribute :seventy_years_old_months, String
    attribute :work_in_multiple_company, Integer
    attribute :will_change_monthly_income, Integer
    attribute :join_middle_of_month, Integer
    attribute :leave_of_absence, Integer
    attribute :short_time_worker, Integer
    attribute :part_time_worker, Integer
    attribute :annual_average_caluculation, Integer
    attribute :memo, String
    attribute :submit_only_seventy_years_and_over, Integer

    define_format_date_method :birth_at, :applied_at, :old_applied_at, :income_updated_at, :retroacted_payment_at
    define_code_mapper_method :birth_at_era_nengo, :applied_at_era_nengo,
                              :old_applied_at_era_nengo, :income_updated_at_era_nengo,
                              :ip_type, :income_updated_type
    define_in_k_method :old_monthly_standard_income_hel_ins, :old_monthly_standard_income_pns_ins

    validates :prefecture_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }
    validates :ip_code, charset: { accept: [:numeric] }, sjis_bytesize: { in: 1..6 }
    validates :ip_name_yomi, charset: { accept: [:katakana] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :half_width }
    validates :ip_name, charset: { accept: [:all] }, sjis_bytesize: { in: 0..24 }, allow_blank: true, space_divider: { space: :full_width }
    validates :applied_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }
    validates :old_monthly_standard_income_hel_ins, numericality: { greater_than_or_equal_to: 1_000, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :old_monthly_standard_income_pns_ins, numericality: { greater_than_or_equal_to: 1_000, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :old_applied_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }
    validates :apr_days, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
    validates :may_days, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
    validates :jun_days, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
    COVERED_MONTHS.each do |month|
      validates "#{month}_income_currency", numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
      validates "#{month}_income_goods", numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
    end
    validates :avg_adjustment, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :ip_type, inclusion: { in: %i[ip_type_0 ip_type_1 ip_type_2] }
    validates :retroacted_payment, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }, allow_blank: true
    validates :retroacted_payment_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }, allow_blank: true
    validates :income_updated_type, inclusion: { in: %i[income_updated_type_0 income_updated_type_1] }, allow_blank: true
    validates :income_updated_at, timeliness: { on_or_after: -> { Date.new(1989, 1, 8) }, type: :date }, allow_blank: true
    validates :my_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 12 }, allow_blank: true
    validates :area_code_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }, allow_blank: true
    validates :serial_number_of_basic_pension_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 8 }, allow_blank: true
    validates :seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true
    validates :seventy_years_old_months, charset: { accept: [:numeric] }, sjis_bytesize: { in: 2..4 }, allow_blank: true
    validates :work_in_multiple_company, inclusion: { in: [1] }, allow_nil: true
    validates :will_change_monthly_income, inclusion: { in: [1] }, allow_nil: true
    validates :join_middle_of_month, inclusion: { in: [1] }, allow_nil: true
    validates :leave_of_absence, inclusion: { in: [1] }, allow_nil: true
    validates :short_time_worker, inclusion: { in: [1] }, allow_nil: true
    validates :part_time_worker, inclusion: { in: [1] }, allow_nil: true
    validates :annual_average_caluculation, inclusion: { in: [1] }, allow_nil: true
    validates :memo, charset: { accept: [:all] }, sjis_bytesize: { in: 0..75 }
    validates :submit_only_seventy_years_and_over, inclusion: { in: [1] }, allow_nil: true
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
        '09',
        old_monthly_standard_income_hel_ins.nil? ? nil : old_monthly_standard_income_hel_ins_in_k.to_s.rjust(4, '0'),
        old_monthly_standard_income_pns_ins.nil? ? nil : old_monthly_standard_income_pns_ins_in_k.to_s.rjust(4, '0'),
        mapped_old_applied_at_era_nengo,
        old_applied_at_era_year,
        old_applied_at_month,
        income_updated_at.nil? ? nil : income_updated_at_month,
        mapped_income_updated_type,
        retroacted_payment_at.nil? ? nil : retroacted_payment_at_month,
        retroacted_payment.nil? ? nil : retroacted_payment.to_s.rjust(7, '0'),
        '04',
        '05',
        '06',
        apr_days.to_s.rjust(2, '0'),
        may_days.to_s.rjust(2, '0'),
        jun_days.to_s.rjust(2, '0'),
        apr_income_currency.to_s.rjust(7, '0'),
        may_income_currency.to_s.rjust(7, '0'),
        jun_income_currency.to_s.rjust(7, '0'),
        apr_income_goods.to_s.rjust(7, '0'),
        may_income_goods.to_s.rjust(7, '0'),
        jun_income_goods.to_s.rjust(7, '0'),
        income_total(apr_income_currency, apr_income_goods).to_s.rjust(7, '0'),
        income_total(may_income_currency, may_income_goods).to_s.rjust(7, '0'),
        income_total(jun_income_currency, jun_income_goods).to_s.rjust(7, '0'),
        income_all_total.to_s.rjust(7, '0'),
        income_average.to_s.rjust(7, '0'),
        avg_adjustment.nil? ? nil : avg_adjustment.to_s.rjust(7, '0'),
        my_number,
        area_code_of_basic_pension_number,
        serial_number_of_basic_pension_number,
        seventy_years_and_over,
        seventy_years_old_months,
        work_in_multiple_company,
        will_change_monthly_income,
        join_middle_of_month,
        leave_of_absence,
        short_time_worker,
        part_time_worker,
        annual_average_caluculation,
        memo,
        submit_only_seventy_years_and_over
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
    # rubocop:enable all

    def income_total(currency, goods)
      total = currency.to_i + goods.to_i
      total < 10_000_000 ? total : 9_999_999
    end

    # 総計を計算する
    # 算定対象月の合計値を返す。
    def income_all_total
      return 0 if target_months.empty?

      target_months.map do |month|
        send("#{month}_income_currency").to_i + send("#{month}_income_goods").to_i
      end.inject(:+)
    end

    # 平均額を計算する
    #
    # 算定対象月の合計値を算定対象月数で割った値を返す。
    #
    # ただし、
    # - 1 円未満は切り捨て
    # - 10,000,000 円以上は 9,999,999 を返す
    # - 算定対象月が存在しない場合は「0」を返す
    def income_average
      return 0 if target_months.empty?

      avg = income_all_total / target_months.length
      avg < 10_000_000 ? avg : 9_999_999
    end

    # 算定対象月の配列を返却する
    #
    # 1. 一般の被保険者の場合
    #    17 日以上の月を対象とする
    #
    # 2. 短時間労働者の場合
    #    11 日以上の月を対象とする
    #
    # 3. パートタイマーの場合
    #    17 日以上の月を対象とする。
    #    ただし、全ての算定基礎月の支払基礎日数が 17 日未満の場合は、
    #    15 日以上の月を対象とする。
    def target_months
      threshold = case ip_type
                  when :ip_type_0
                    17
                  when :ip_type_1
                    COVERED_MONTHS.all? { |month| send("#{month}_days").to_i < 17 } ? 15 : 17
                  when :ip_type_2
                    11
                  else
                    17
                  end
      COVERED_MONTHS.select { |month| threshold <= send("#{month}_days").to_i }
    end

    private

    def seventy_years_and_over_employee_need_to_input_my_number_or_basic_pension_number
      return if seventy_years_and_over.nil?

      errors.add(:base, '70歳以上被用者の場合、マイナンバー、もしくは基礎年金番号の入力は必須です。') if my_number.nil? && area_code_of_basic_pension_number.nil? && serial_number_of_basic_pension_number.nil?
    end
  end
end
