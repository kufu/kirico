# frozen_string_literal: true
require 'virtus'
require 'active_model'

module Kirico
  class BaseCompanyCount
    include Virtus.model
    include ActiveModel::Validations
  end
end
