# frozen_string_literal: true
require 'virtus'
require 'active_model'

# 社会保険労務士: 事業所数情報
module Kirico
  class SrCompanyCount
    include Virtus.model
    include ActiveModel::Validations

    COUNT = '001'

    attribute :name, String

    validates :name, charset: { accept: [:katakana, :kanji] }, sjis_bytesize: { in: 1..25 }

    def initialize
      super
    end

    def to_csv
      [name, COUNT].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
