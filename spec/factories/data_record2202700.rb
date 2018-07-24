# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコード
FactoryGirl.define do
  factory :data_record2202700, class: Kirico::DataRecord2202700 do
    address_pref_type :address_pref_type_21
    area_code '01'
    office_code 'ｱｲｳ'
    owner_confirmation_type :owner_confirmation_type_0
    owner_accepted_at Date.new(2018, 7, 10)
    ip_code '000003'
    ip_name_yomi 'ﾀﾅｶ ｹﾝｽｹ'
    ip_name '田中 研介'
    birth_at Date.new(1984, 7, 23)
    gender_type :gender_type_1
    my_number_digits '000000000000'
    basic_pension_number1 '1482'
    basic_pension_number2 '857028'
    salary 3_800_000
    zip_code1 nil
    zip_code2 nil
    address nil
    change_type :change_type_1
    spouse_annual_income nil
    after(:build) do |record|
      record.spouse_record = FactoryGirl.build(:data_record2202700_spouse)
      record.dependent_record1 = FactoryGirl.build(:data_record2202700_dependent)
    end
  end
end
