# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「配偶者である被扶養者」の情報
FactoryGirl.define do
  factory :data_record2202700_spouse, class: Kirico::DataRecord2202700Spouse do
    change_type :change_type_1
    submit_at Date.new(2018, 7, 10)
    name_yomi 'ﾀﾅｶ ﾅｵ'
    name '田中　菜緒'
    birth_at Date.new(1982, 6, 19)
    gender_type :gender_type_2
    my_number_digits '000000000000'
    basic_pension_number1 '8484'
    basic_pension_number2 '808240'
    nationality '外国籍の場合'
    foreign_name_kana 'ｶﾞｲｺｸｼﾞﾝ ﾂｳｼｮｳ'
    foreign_name '外国人　通称'
    living_together_type :living_together_type_2
    address_pref_type ''
    zip_code1 '739'
    zip_code2 '1742'
    address '広島県広島市安佐北区亀崎'
    tel_number_type :tel_number_type_2
    tel_number1 '080'
    tel_number2 '8383'
    tel_number3 '83838'
    qualified_at Date.new(2018, 7, 1)
    qualified_reason_type :qualified_reason_type_1
    qualified_reason_etc ''
    job_type :job_type_2
    income 900_000
    disqualified_at nil
    disqualified_reason_type nil
    disqualified_reason_etc nil
    death_at nil
    memo 'これが備考だ'
  end
end
