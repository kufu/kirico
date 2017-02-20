# frozen_string_literal: true
require 'virtus'
require 'active_model'

module Kirico
  class Form
    include Virtus.model
    include ActiveModel::Validations

    attribute :fd, Kirico::FDManagementRecord
    attribute :company, Kirico::Company
    attribute :records, Array[Kirico::ApplicationRecord]

    FILE_NAME = 'SHFD0006.CSV'

    def initialize(fd:, company:, records: [])
      @fd = fd
      @company = company
      @records = records
    end

    def to_csv
      [
        @fd.to_csv,
        Kirico::CompanyIdentifier.new.to_csv,
        Kirico::CompanyCount.new.to_csv,
        @company.to_csv,
        Kirico::DataIdentifier.new.to_csv,
        @records.map(&:to_csv).join("\n")
      ].join("\n")
    end
  end
end
