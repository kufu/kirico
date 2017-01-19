# frozen_string_literal: true
module Kirico
  class CSVGenerator
    def initialize(fd_management_record, company, data = [])
      @fd_management_record = fd_management_record
      @company_identifier = CompanyIdentifier.new
      @company_count = CompanyCount.new
      @company = company
      @data_identifier = DataIdentifier.new
      @data = data
    end

    # 1 件: FD 管理レコード
    # 1 件: 事業所識別符号
    # 1 件: 事業所数情報
    # 1 件: データ識別符号
    # n 件: データレコード
    def generate
      [
        @fd_management_record,
        @company_identifier,
        @company_count,
        @company,
        @data_identifier,
        @data
      ].flatten.map(&:to_csv).join("\n")
    end
  end
end
