# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「配偶者である被扶養者」の情報
FactoryGirl.define do
  factory :data_record2202700_dependent, class: Kirico::DataRecord2202700Dependent do
    ip_code nil
    name '田中　太郎'
    name_yomi 'ﾀﾅｶ ﾀﾛｳ'
    birth_at Date.new(1998, 8, 8)
    gender_type :gender_type_1
    relation_type :relation_type_02
    relation_type_etc nil
    my_number_digits '000000000000'
    living_together_type :living_together_type_1
    qualified_at Date.new(2018, 7, 1)
    job_type :job_type_2
    address_pref_type nil
    income 333
    qualified_reason_type :qualified_reason_type_1
    qualified_reason_etc nil
    disqualified_at nil
    disqualified_reason_type nil
    disqualified_reason_etc nil
    memo 'あああ'
  end
end
