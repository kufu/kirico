# frozen_string_literal: true
# 算定基礎届データレコード
FactoryGirl.define do
  factory :data_record22257041, class: Kirico::DataRecord22257041 do
    area_code '14'
    office_code 'ｸﾄﾜ'
    ip_code '000002'
    birth_at Date.new(1984, 5, 27)
    applied_at Date.new(2016, 9, 1)
    ip_name_yomi 'ﾖｼﾀﾞ ﾀﾛｳ'
    ip_name '吉田 太郎'
    gender_type '1'
    old_monthly_standard_income_hel_ins 410_000
    old_monthly_standard_income_pns_ins 200_000
    old_applied_at Date.new(2015, 7, 1)
    apr_days 3
    may_days 24
    jun_days 17
    apr_income_currency 444_444
    may_income_currency 555_555
    jun_income_currency 666_666
    apr_income_goods 444
    may_income_goods 555
    jun_income_goods 666
    avg_adjustment 999
    ip_type :regular_worker
    retroacted_payment 344
    income_updated_type :down
    income_diff_amount 3333
    income_updated_at Date.new(1991, 3, 1)
    memo 'bikoooooo'
  end
end
