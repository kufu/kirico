# frozen_string_literal: true
require 'virtus'

module Kirico
  class FDManagementRecord
    include Virtus.model

    def initialize
      super
    end

    def to_csv
      CSV.table('spec/fixtures/changing_address_SHFD0006.CSV', encoding: 'Shift_JIS:UTF-8', headers: false, converters: nil)[0]
    end
  end
end
