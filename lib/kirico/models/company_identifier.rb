# frozen_string_literal: true
require 'virtus'

module Kirico
  class CompanyIdentifier
    include Virtus.model

    IDENTIFIER = '[kanri]'

    def to_csv
      [IDENTIFIER]
    end
  end
end
