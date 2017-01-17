# frozen_string_literal: true
require 'virtus'

module Kirico
  class DataIdentifier
    include Virtus.model

    IDENTIFIER = '[data]'

    def to_csv
      [IDENTIFIER]
    end
  end
end
