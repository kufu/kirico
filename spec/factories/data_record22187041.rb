# frozen_string_literal: true

# 住所変更届データレコード
FactoryGirl.define do
  factory :data_record22187041, class: Kirico::DataRecord22187041 do
    area_code '14'
    office_code 'ｸﾄﾜ'
    ip_code '000010'
    basic_pension_number1 '2271'
    basic_pension_number2 '174711'
    birth_at Date.new(1987, 5, 27)
    zip_code1 '154'
    zip_code2 '0011'
    new_address_yomi 'ﾄｳｷｮｳﾄｾﾀｶﾞﾔｸｶﾐｳﾏ'
    new_address '東京都世田谷区上馬'
    updated_at Date.new(2017, 1, 3)
    ip_name_yomi 'ﾀﾅｶ ﾀﾛｳ'
    ip_name '田中　太郎'
    old_address_yomi 'ﾄｳｷｮｳﾄﾈﾘﾏｸﾄﾖﾀﾏｶﾐ'
    old_address '東京都練馬区豊玉上2-5-1モゲラ801'
    memo '備考備考'
  end
end
