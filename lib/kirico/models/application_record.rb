# frozen_string_literal: true

require 'virtus'
require 'active_model'
require 'kirico/models/helper'
require 'validates_timeliness'

module Kirico
  class ApplicationRecord
    include Virtus.model
    include ActiveModel::Validations
    extend Kirico::Helper

    def initialize
      yield(self) if block_given?
    end

    def to_csv
      raise NotImplementedError
    end
  end
end
