# frozen_string_literal: true
require 'virtus'
require 'kirico/models/helper'

module Kirico
  class FDManagementRecord
    include Virtus.model
    extend Kirico::Helper

    MAIN_DOC_CODE = '22223'

    attribute :area_code, String
    attribute :office_code, String
    attribute :fd_seq_number, String
    attribute :created_at, Date

    define_format_date_method :created_at

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
  end
end
