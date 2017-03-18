# frozen_string_literal: true
require 'virtus'
require 'active_model'
require 'kirico/models/helper'

# 社会保険労務士: FD 管理レコード
module Kirico
  class SrFDManagementRecord
    include Virtus.model
    include ActiveModel::Validations
    extend Kirico::Helper

    MAIN_DOC_CODE = '22223'

    attribute :sr_code, String
    attribute :fd_seq_number, String
    attribute :created_at, Date

    validates :sr_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }
    validates :fd_seq_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }

    define_format_date_method :created_at

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      [
        '',
        sr_code,
        fd_seq_number,
        fmt_ymd_created_at,
        MAIN_DOC_CODE
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
