# frozen_string_literal: true
require 'virtus'
require 'active_model'
require 'kirico/models/helper'

module Kirico
  class BaseFDManagementRecord
    include Virtus.model
    include ActiveModel::Validations
    extend Kirico::Helper

    MAIN_DOC_CODE = '22223'

    attribute :fd_seq_number, String
    attribute :created_at, Date

    validates :fd_seq_number, charset: { accept: [:numeric] }, sjis_bytesize: { is: 3 }

    define_format_date_method :created_at

    def initialize
      yield(self) if block_given?
    end
  end
end
