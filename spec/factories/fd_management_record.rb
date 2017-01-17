# frozen_string_literal: true
FactoryGirl.define do
  factory :fd_management_record, class: Kirico::FDManagementRecord do
    area_code '14'
    office_code 'ｸﾄﾜ'
    fd_seq_number '005'
    created_at '2017-01-17'
  end
end
