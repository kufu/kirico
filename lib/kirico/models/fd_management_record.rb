# frozen_string_literal: true
require 'virtus'

module Kirico
  class FDManagementRecord
    include Virtus.model

    MAIN_DOC_CODE = '22223'

    attribute :area_code, String
    attribute :office_code, String
    attribute :fd_seq_number, String
    attribute :created_at, Date

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        area_code,
        office_code,
        fd_seq_number,
        fmt_created_at,
        MAIN_DOC_CODE
      ].join(',')
    end

    def fmt_created_at
      return nil if created_at.nil?
      created_at.strftime('%Y%m%d')
    end
  end
end
