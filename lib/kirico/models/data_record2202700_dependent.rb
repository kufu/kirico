# frozen_string_literal: true

# 被扶養者(異動)届・国民年金第３号被保険者関係届データレコードのうち「その他の被扶養者1~3」の情報
module Kirico
  class DataRecord2202700SDependent < ApplicationRecord
    attribute :ip_code, String
    attribute :name, String
    attribute :name_yomi, String
    attribute :birth_at, Date
    attribute :gender_type, String
    attribute :relation_type, String
    attribute :relation_type_etc, String
    attribute :my_number_digits, String
    attribute :living_together_type, String
    attribute :qualified_at, Date
    attribute :job, String
    attribute :address, String
    attribute :income, String
    attribute :qualified_reason_type, String
    attribute :qualified_reason_etc, String
    attribute :disqualified_at, Date
    attribute :disqualified_reason_type, String
    attribute :disqualified_reason_etc, String
    attribute :memo, String
  end

  def to_csv
    [
      ip_code,
      name,
      name_yomi,
      mapped_birth_at_nengo,
      fmt_era_ymd_birth_at,
      mapped_gender_type,
      mapped_relation_type,
      relation_type_etc,
      my_number_digits,
      living_together_type,
      mapped_spouse_qualified_at_nengo,
      fmt_era_ymd_spouse_qualified_at,
      job,
      address,
      income,
      qualified_reason_type,
      qualified_reason_etc,
      mapped_disqualified_at_nengo,
      fmt_era_ymd_disqualified_at,
      disqualified_reason_type,
      disqualified_reason_etc,
      memo
    ].map { |attr| attr.to_s.encode('CP932') }.join(',')
  end
end
