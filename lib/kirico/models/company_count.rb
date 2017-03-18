# frozen_string_literal: true
require 'virtus'
require 'active_model'

module Kirico
  class CompanyCount
    include Virtus.model
    include ActiveModel::Validations

    COUNT = '001'

    def initialize
      super
    end

    def to_csv
      [nil, COUNT].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
