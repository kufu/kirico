# frozen_string_literal: true

FactoryBot.define do
  factory :sr_fd_management_record, class: Kirico::SrFDManagementRecord do
    sr_code { '0007' }
    fd_seq_number { '004' }
    created_at { Date.new(2017, 2, 27) }
  end
end
