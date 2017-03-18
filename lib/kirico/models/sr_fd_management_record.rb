# frozen_string_literal: true
require 'kirico/models/base_fd_management_record'

# 社会保険労務士: FD 管理レコード
module Kirico
  class SrFDManagementRecord < BaseFDManagementRecord
    attribute :sr_code, String

    validates :sr_code, charset: { accept: [:numeric] }, sjis_bytesize: { is: 4 }

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
