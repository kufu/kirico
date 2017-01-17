# frozen_string_literal: true
require 'virtus'

module Kirico
  class DataIdentifier
    include Virtus.model

    IDENTIFIER = '[data]'

    def to_csv
      [IDENTIFIER].join(',')
    end
  end
end
