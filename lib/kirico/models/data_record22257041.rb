# frozen_string_literal: true
# 算定基礎届データレコード
module Kirico
  class DataRecord22257041 < ApplicationRecord
    DOC_CODE = '22257041'
    COVERED_MONTHS = [:apr, :may, :jun].freeze

    attribute :area_code, String
    attribute :office_code, String
    attribute :ip_code, String
    attribute :birth_at, Date
    attribute :applied_at, Date
    attribute :ip_name_yomi, String
    attribute :ip_name, String
    attribute :gender_type, String
    attribute :old_monthly_standard_income_hel_ins, Integer
    attribute :old_monthly_standard_income_pns_ins, Integer
    attribute :old_applied_at, Date
    COVERED_MONTHS.each do |month|
      attribute "#{month}_days", Integer
      attribute "#{month}_income_currency", Integer
      attribute "#{month}_income_goods", Integer
    end
    attribute :avg_adjustment, Integer
    attribute :ip_type, Symbol
    attribute :retroacted_payment, Integer
    attribute :income_updated_type, Symbol
    attribute :income_diff_amount, Integer
    attribute :income_updated_at, Date
    attribute :memo, String

    define_format_date_method :birth_at, :applied_at, :old_applied_at, :income_updated_at
    define_code_mapper_method :birth_at_era_nengo, :applied_at_era_nengo,
                              :old_applied_at_era_nengo, :income_updated_at_era_nengo,
                              :ip_type, :income_updated_type
    define_in_k_method :old_monthly_standard_income_hel_ins, :old_monthly_standard_income_pns_ins

    def initialize
      yield(self) if block_given?
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def to_csv
      [
        DOC_CODE,
        area_code,
        office_code,
        ip_code,
        mapped_birth_at_era_nengo,
        fmt_era_ymd_birth_at,
        '',
        mapped_applied_at_era_nengo,
        applied_at_era_year,
        applied_at_month,
        ip_name_yomi,
        ip_name,
        gender_type,
        old_monthly_standard_income_hel_ins_in_k.to_s.rjust(4, '0'),
        old_monthly_standard_income_pns_ins_in_k.to_s.rjust(4, '0'),
        mapped_old_applied_at_era_nengo,
        old_applied_at_era_year,
        old_applied_at_month,
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
        income_average.to_s.rjust(7, '0'),
        avg_adjustment.nil? ? nil : avg_adjustment.to_s.rjust(7, '0'),
        mapped_ip_type,
        '',
        '',
        '',
        retroacted_payment.nil? ? nil : retroacted_payment.to_s.rjust(7, '0'),
        mapped_income_updated_type,
        income_diff_amount.nil? ? nil : income_diff_amount.to_s.rjust(7, '0'),
        income_updated_at.nil? ? nil : income_updated_at_era_year,
        income_updated_at.nil? ? nil : income_updated_at_month,
        memo
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def income_total(currency, goods)
      total = currency.to_i + goods.to_i
      total < 10_000_000 ? total : 9_999_999
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
      total = target_months.map do |month|
        send("#{month}_income_currency").to_i + send("#{month}_income_goods").to_i
      end.inject(:+)
      avg = total / target_months.length
      avg < 10_000_000 ? avg : 9_999_999
    end

    # 算定対象月の配列を返却するs
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
                  when :regular_worker
                    17
                  when :part_timer
                    COVERED_MONTHS.all? { |month| send("#{month}_days").to_i < 17 } ? 15 : 17
                  when :part_timer_at_enterprise
                    11
                  else
                    17
                  end
      COVERED_MONTHS.select { |month| threshold <= send("#{month}_days").to_i }
    end
  end
end
