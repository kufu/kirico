# frozen_string_literal: true
require 'virtus'
require 'active_model'
require 'kirico/models/helper'

module Kirico
  class FDManagementRecord
    include Virtus.model
    include ActiveModel::Validations
    extend Kirico::Helper

    MAIN_DOC_CODE = '22223'

    attribute :area_code, String
    attribute :office_code, String
    attribute :fd_seq_number, String
    attribute :created_at, Date

    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: [:numeric, :latin, :katakana] }, sjis_bytesize: { in: 1..4 }
    validates :fd_seq_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }

    define_format_date_method :created_at

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        area_code,
        office_code,
        fd_seq_number,
        fmt_ymd_created_at,
        MAIN_DOC_CODE
      ].join(',')
    end
  end
end
