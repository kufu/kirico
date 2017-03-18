# frozen_string_literal: true
FactoryGirl.define do
  factory :form, class: Kirico::Form do
    initialize_with {
      new(
        fd: FactoryGirl.build(:fd_management_record),
        company: FactoryGirl.build(:company),
        records: FactoryGirl.build_list(:changing_address_record, 3)
      )
    }
  end

  factory :sr_form, class: Kirico::Form do
    initialize_with {
      new(
        fd: FactoryGirl.build(:sr_fd_management_record),
        company_count: FactoryGirl.build(:sr_company_count),
        company: FactoryGirl.build(:company),
        records: FactoryGirl.build_list(:changing_address_record, 3)
      )
    }
  end
end
