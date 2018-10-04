# frozen_string_literal: true

FactoryBot.define do
  factory :form, class: Kirico::Form do
    initialize_with {
      new(
        fd: FactoryBot.build(:fd_management_record),
        company: FactoryBot.build(:company),
        records: FactoryBot.build_list(:data_record22187041, 3)
      )
    }
  end

  factory :sr_form, class: Kirico::Form do
    initialize_with {
      new(
        fd: FactoryBot.build(:sr_fd_management_record),
        company_count: FactoryBot.build(:sr_company_count),
        company: FactoryBot.build(:company),
        records: FactoryBot.build_list(:data_record22187041, 3)
      )
    }
  end
end
