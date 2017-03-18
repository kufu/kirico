# frozen_string_literal: true
require 'kirico/models/base_company_count'

module Kirico
  class CompanyCount < BaseCompanyCount
    COUNT = '001'

    def to_csv
      [nil, COUNT].map { |attr| attr.to_s.encode('CP932') }.join(',')
    end
  end
end
