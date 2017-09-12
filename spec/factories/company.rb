# frozen_string_literal: true

FactoryGirl.define do
  factory :company, class: Kirico::Company do
    area_code '14'
    office_code 'ｸﾄﾜ'
    office_number '77362'
    zip_code1 '106'
    zip_code2 '0041'
    address '東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601'
    name '株式会社クフ'
    owner_name '吉田　ケイ　松蔭'
    tel_number '03-5563-7662'
  end
end
