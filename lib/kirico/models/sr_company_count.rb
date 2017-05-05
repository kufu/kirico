# frozen_string_literal: true
require 'kirico/models/base_company_count'

# 社会保険労務士: 事業所数情報
module Kirico
  class SrCompanyCount < BaseCompanyCount
    COUNT = '001'

    attribute :name, String

    validates :name, charset: { accept: [:katakana, :kanji] }, sjis_bytesize: { in: 1..25 }, space_divider: { space: :both_width }

    def to_csv
      [name, COUNT].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
