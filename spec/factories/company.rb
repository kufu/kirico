# frozen_string_literal: true

FactoryBot.define do
  factory :company, class: Kirico::Company do
    prefecture_code { '21' }
    area_code { '14' }
    office_code { 'ｸﾄﾜ' }
    office_number { '77362' }
    zip_code1 { '106' }
    zip_code2 { '0041' }
    address { '東京都港区麻布台1-4-3 エグゼクティブタワー麻布台601' }
    name { '株式会社クフ' }
    owner_name { '吉田　ケイ　松蔭' }
    tel_area_code { '03' }
    tel_city_code { '5563' }
    tel_subscriber_number { '7662' }
  end
end
