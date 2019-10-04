# frozen_string_literal: true

# 賞与支払届データレコード
FactoryBot.define do
  factory :data_record2265700, class: Kirico::DataRecord2265700 do
    prefecture_code { '21' }
    area_code { '14' }
    office_code { 'ｸﾄﾜ' }
    ip_code { '000002' }
    birth_at { Date.new(1984, 5, 27) }
    payed_bonus_at { Date.new(2019, 9, 1) }
    ip_name_yomi { 'ﾖｼﾀﾞ ﾀﾛｳ' }
    ip_name { '吉田　太郎' }
    payment_in_currency { 444_444 }
    payment_in_goods { 555_555 }
    my_number { '012345678901' }
    area_code_of_basic_pension_number { '0123' }
    serial_number_of_basic_pension_number { '123456' }
  end
end
