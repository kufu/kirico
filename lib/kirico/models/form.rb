# frozen_string_literal: true

require 'virtus'
require 'active_model'

module Kirico
  class Form
    include Virtus.model
    include ActiveModel::Validations

    FILE_NAME = 'SHFD0006.CSV'

    attribute :fd, Kirico::BaseFDManagementRecord
    attribute :company_count, Kirico::BaseCompanyCount
    attribute :company, Kirico::Company
    attribute :records, Array[Kirico::ApplicationRecord]

    validates :fd, :company_count, :company, :records, presence: true
    validate :validate_children

    def initialize(fd:, company_count: Kirico::CompanyCount.new, company:, records: [])
      @fd = fd
      @company_count = company_count
      @company = company
      @records = records
    end

    def to_csv
      [
        @fd.to_csv,
        Kirico::CompanyIdentifier.new.to_csv,
        @company_count.to_csv,
        @company.to_csv,
        Kirico::DataIdentifier.new.to_csv,
        @records.map(&:to_csv).join("\r\n"),
        ''
      ].join("\r\n")
    end

    private

    # 子のエラーを自身のエラーとして設定する
    def validate_children
      %i[fd company company_count].each do |attribute|
        rec = send(attribute)
        next if rec.nil? || rec.valid?

        rec.errors.full_messages.each do |msg|
          errors.add(attribute, msg)
        end
      end

      # 2行以上存在する場合は、何行目でエラーが起きたのかを知りたい
      records.each.with_index(1) do |rec, i|
        next if rec.valid?

        row = I18n.t('errors.row_counter', num: i) if records.length > 1
        rec.errors.full_messages.each do |msg|
          errors.add(:records, "#{row}#{msg}")
        end
      end
    end
  end
end
