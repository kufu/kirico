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
end
