# frozen_string_literal: true
require 'virtus'

module Kirico
  class ChangingAddressForm
    include Virtus.model

    def to_csv
      'foo'
    end
  end
end
