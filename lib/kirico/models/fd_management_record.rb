# frozen_string_literal: true

require 'kirico/models/base_fd_management_record'

module Kirico
  class FDManagementRecord < BaseFDManagementRecord
    attribute :prefecture_code, String
    attribute :area_code, String
    attribute :office_code, String

    validates :prefecture_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :area_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 2 }
    validates :office_code, charset: { accept: %i[numeric latin katakana] }, sjis_bytesize: { in: 1..4 }

    def to_csv
      [
        prefecture_code,
        area_code,
        office_code,
        fd_seq_number,
        fmt_ymd_created_at,
        MAIN_DOC_CODE
      ].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
