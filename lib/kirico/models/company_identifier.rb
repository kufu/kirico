# frozen_string_literal: true
require 'virtus'

module Kirico
  class CompanyIdentifier
    include Virtus.model

    IDENTIFIER = '[kanri]'

    def to_csv
      [IDENTIFIER].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
