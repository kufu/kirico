# frozen_string_literal: true

# 月額変更届データレコード
FactoryBot.define do
  factory :data_record2221700, class: Kirico::DataRecord2221700 do
    prefecture_code { '21' }
    area_code { '57' }
    office_code { 'ｹﾏ' }
    ip_code { '17' }
    ip_name_yomi { 'ｺｳﾈﾝ ｻﾌﾞﾛｳ' }
    ip_name { '厚年　三郎' }
    birth_at { Date.new(1960, 7, 8) }
    applied_at { Date.new(2019, 12, 1) }
    old_monthly_standard_income_hel_ins { 260_000 }
    old_monthly_standard_income_pns_ins { 260_000 }
    old_applied_at { Date.new(2019, 9, 1) }
    income_updated_at { Date.new(2019, 9, 1) }
    income_updated_type { :income_updated_type_0 }
    retroacted_payment_at { nil }
    retroacted_payment { nil }
    before_3_month_days { 31 }
    before_2_month_days { 30 }
    before_1_month_days { 31 }
    before_3_month_income_currency { 300_000 }
    before_2_month_income_currency { 300_000 }
    before_1_month_income_currency { 300_000 }
    before_3_month_income_goods { 0 }
    before_2_month_income_goods { 0 }
    before_1_month_income_goods { 0 }
    avg_adjustment { nil }
    my_number { nil }
    area_code_of_basic_pension_number { nil }
    serial_number_of_basic_pension_number { nil }
    seventy_years_and_over { nil }
    work_in_multiple_company { nil }
    short_time_worker { nil }
    reason { '基本給の変更' }
    change_only_hel_ins { nil }
    memo { nil }
    submit_only_seventy_years_and_over { nil }
  end
end
